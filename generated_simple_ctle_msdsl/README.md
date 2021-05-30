# Generating synthesizable analog models

## Installation

For best repeatability, I recommend running this example in its own conda environment.  But it should work in a less controlled environment.  The steps below install requirements for the example: **msdsl**, which includes **svreal**, along with a YAML reader.  The last two lines set environment variables pointing to directories containing the Verilog header files for **svreal** and **msdsl**, which are installed as part of their respective Python packages.

```shell
$ conda create -n fixture_msdsl python=3.7
$ conda activate fixture_msdsl
$ pip install -r requirements.txt
$ export SVREAL_INST_DIR=`python -c 'import svreal; print(svreal.PACK_DIR)'`
$ export MSDSL_INST_DIR=`python -c 'import sys, os; sys.stdout=open(os.devnull, "w"); import msdsl; sys.stdout = sys.__stdout__; print(msdsl.files.PACK_DIR)'`
```

## Generating the synthesizable model

Just run the Python script ``run.py``:

```shell
$ python run.py
```

You'll get a warning message about ``msdsl.circuit`` being experimental, but that's OK.  The warning will be removed in a future version.  For more information about the **msdsl** implementation, check out the comments in ``run.py``.

## Running the code

You can run a Verilog testbench for the generated model using this command:

```shell
$ iverilog -I$SVREAL_INST_DIR -I$MSDSL_INST_DIR -g2012 -DCLK_MSDSL=ctle_tb.emu_clk -DRST_MSDSL=ctle_tb.emu_rst ctle.sv ctle_tb.sv
$ vvp a.out
```

You'll see two warnings about ``readmemb`` but they can be ignored safely.  I created the testbench by modifying ``ctle_tb.sv`` from ``generated_build_simple_ctle``.  There are some comments about the changes in the testbench file.

