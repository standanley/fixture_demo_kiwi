import yaml
from math import pi
from pathlib import Path

from msdsl import MixedSignalModel, VerilogGenerator, RangeOf

THIS_DIR = Path(__file__).resolve().parent
BUILD_DIR = THIS_DIR


def read_yaml(f):
    with open(f, 'r') as stream:
        return yaml.safe_load(stream)


class FixtureCTLE(MixedSignalModel):
    def __init__(self, circuit_cfg, params_yaml, dt=0.01e-9, **kwargs):
        # NOTE: if you change the value of dt, change it in ctle_tb.sv as well

        # read the two yaml files
        circuit = read_yaml(circuit_cfg)
        params = read_yaml(params_yaml)

        # call super constructor
        # the dt argument is set to "1" since the time constants
        # will be normalized to the user specified dt value.  this
        # is kludgy, but avoids a numerical issue in MixedSignalModel
        # that occurs when time constants are small
        super().__init__(module_name=circuit['module_name'], dt=1, **kwargs)

        # build the model I/O
        self.add_circuit_pins(circuit['pin'])

        # process the model parameters
        read_param = lambda name: params['test1'][name][0]['coef']['1']
        dcgain = read_param('dcgain')
        tau_p1 = (1/(2*pi*read_param('fp1')))/dt
        tau_p2 = (1/(2*pi*read_param('fp2')))/dt
        tau_z1 = (1/(2*pi*read_param('fz1')))/dt
        v_oc = read_param('v_oc')

        # calculate differential input
        v_id = self.bind_name('v_id', dcgain*(self.cpins['inp'] - self.cpins['inn']))

        # apply transfer function
        tf_num = [tau_z1, 1]
        tf_den = [tau_p1 * tau_p2, tau_p1 + tau_p2, 1]
        v_od = self.add_analog_state('v_od', range_=RangeOf(v_id))
        self.set_tf(v_id, v_od, (tf_num, tf_den))

        # assign output
        self.set_this_cycle(self.cpins['outp'], v_oc + 0.5*v_od)
        self.set_this_cycle(self.cpins['outn'], v_oc - 0.5*v_od)

    def add_circuit_pins(self, pin):
        self.cpins = {}
        for k, v in pin.items():
            if v['direction'] == 'input':
                if v['datatype'] == 'real':
                    self.cpins[k] = self.add_analog_input(v['name'])
                else:
                    raise Exception(f"Unsupported pin datatype: {v['datatype']}")
            elif v['direction'] == 'output':
                if v['datatype'] == 'real':
                    self.cpins[k] = self.add_analog_output(v['name'])
                else:
                    raise Exception(f"Unsupported pin datatype: {v['datatype']}")
            else:
                raise Exception(f"Unsupported pin direction: {v['direction']}")


def main():
    # make the build directory
    BUILD_DIR.mkdir(exist_ok=True, parents=True)

    # create the model
    m = FixtureCTLE(
        circuit_cfg=THIS_DIR / 'circuit.cfg',
        params_yaml=THIS_DIR / 'params.yaml',
        build_dir=BUILD_DIR
    )

    # write the file
    m.compile_to_file(VerilogGenerator())


if __name__ == '__main__':
    main()
