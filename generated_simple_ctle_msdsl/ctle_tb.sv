`timescale 1fs/1fs

`include "svreal.sv"

// NOTE: if you change the value of DT_MSDSL, change it in run.py as well
`define DT_MSDSL 0.01e-9

module ctle_tb;

    real vdd;
    real vss;
    real vinp;
    real voutp;
    real vinn;
    real voutn;

    // declare svreal signals
    `MAKE_REAL(vdd_svreal, 2.5);
    `MAKE_REAL(vss_svreal, 2.5);
    `MAKE_REAL(vinp_svreal, 2.5);
    `MAKE_REAL(voutp_svreal, 2.5);
    `MAKE_REAL(vinn_svreal, 2.5);
    `MAKE_REAL(voutn_svreal, 2.5);

    // map to real numbers
    assign `FORCE_REAL(vdd, vdd_svreal);
    assign `FORCE_REAL(vss, vss_svreal);
    assign `FORCE_REAL(vinp, vinp_svreal);
    assign voutp = `TO_REAL(voutp_svreal);
    assign `FORCE_REAL(vinn, vinn_svreal);
    assign voutn = `TO_REAL(voutn_svreal);

    // instantiate model
    ctle #(
        `PASS_REAL(vdd, vdd_svreal),
        `PASS_REAL(vss, vss_svreal),
        `PASS_REAL(vinp, vinp_svreal),
        `PASS_REAL(voutp, voutp_svreal),
        `PASS_REAL(vinn, vinn_svreal),
        `PASS_REAL(voutn, voutn_svreal)
    ) dut (
        .vdd(vdd_svreal),
        .vss(vss_svreal),
        .vinp(vinp_svreal),
        .voutp(voutp_svreal),
        .vinn(vinn_svreal),
        .voutn(voutn_svreal)
    );

    // define how delays are implemented
    logic emu_clk, emu_rst;
    integer idelay, cycles;
    task delay(input real t);
        cycles = (1.0*t)/(1.0*(`DT_MSDSL));
        if (cycles == 0) begin
            #0;
        end else begin
            for (idelay=0; idelay<cycles; idelay=idelay+1) begin
                emu_clk = 0;
                #((0.5*(`DT_MSDSL))*1s);
                emu_clk = 1;
                #((0.5*(`DT_MSDSL))*1s);
            end
        end
    endtask

    // main test

    initial begin
        // waveform probing
        $dumpfile("waveforms_msdsl.vcd");

        // to probe all waveforms, uncomment this line
        // $dumpvars(0, ctle_tb.vdd);

        // by default, probe only certain waveforms
        // to keep waveform file sizes small
        $dumpvars(0, ctle_tb.vdd);
        $dumpvars(0, ctle_tb.vss);
        $dumpvars(0, ctle_tb.vinp);
        $dumpvars(0, ctle_tb.voutp);
        $dumpvars(0, ctle_tb.vinn);
        $dumpvars(0, ctle_tb.voutn);

        // initialize
        emu_clk = 0;
        emu_rst = 1;
        delay(`DT_MSDSL);
        emu_rst = 0;

        // run test (removed file writing and replaced # delays
        // with calls to delay()

        vdd <= 1.8;
        delay(0);
        vss <= 0;
        delay(0);




        delay(1e-9);
        vinp <= 0.8859382209404254;
        delay(0);
        vinn <= 0.9207223413512122;
        delay(0);
        delay(1e-9);
        vinp <= 0.9152890571351513;
        delay(0);
        vinn <= 0.8913715051564863;
        delay(0);


        delay(1.1e-9);




        delay(1e-9);
        vinp <= 0.9112893869874528;
        delay(0);
        vinn <= 0.9157220098663337;
        delay(0);
        delay(1e-9);
        vinp <= 0.936405450941883;
        delay(0);
        vinn <= 0.8906059459119035;
        delay(0);


        delay(1.1e-9);




        delay(1e-9);
        vinp <= 0.8983947265591615;
        delay(0);
        vinn <= 0.9427077324765732;
        delay(0);
        delay(1e-9);
        vinp <= 0.9365015596928463;
        delay(0);
        vinn <= 0.9046008993428885;
        delay(0);


        delay(1.1e-9);




        delay(1e-9);
        vinp <= 0.8854665655433138;
        delay(0);
        vinn <= 0.9322551233783813;
        delay(0);
        delay(1e-9);
        vinp <= 0.9329152153350821;
        delay(0);
        vinn <= 0.884806473586613;
        delay(0);


        delay(1.1e-9);




        delay(1e-9);
        vinp <= 0.9135356913669516;
        delay(0);
        vinn <= 0.9466167395209636;
        delay(0);
        delay(1e-9);
        vinp <= 0.9454022113735691;
        delay(0);
        vinn <= 0.9147502195143461;
        delay(0);
        
        
        delay(1.1e-9);
        
        
        
        
        delay(1e-9);
        vinp <= 0.9195031604342003;
        delay(0);
        vinn <= 0.9330625837550124;
        delay(0);
        delay(1e-9);
        vinp <= 0.9465332205559288;
        delay(0);
        vinn <= 0.9060325236332839;
        delay(0);
        
        
        delay(1.1e-9);
        
        
        
        
        delay(1e-9);
        vinp <= 0.9234715570944307;
        delay(0);
        vinn <= 0.9714835301210138;
        delay(0);
        delay(1e-9);
        vinp <= 0.9671087782295958;
        delay(0);
        vinn <= 0.9278463089858487;
        delay(0);
        
        
        delay(1.1e-9);
        
        
        
        
        delay(1e-9);
        vinp <= 0.9217958338138267;
        delay(0);
        vinn <= 0.9685179244137704;
        delay(0);
        delay(1e-9);
        vinp <= 0.9685616961926206;
        delay(0);
        vinn <= 0.9217520620349765;
        delay(0);
        
        
        delay(1.1e-9);
        
        
        
        
        delay(1e-9);
        vinp <= 0.9219413609306275;
        delay(0);
        vinn <= 0.9588420497567278;
        delay(0);
        delay(1e-9);
        vinp <= 0.9567778029055556;
        delay(0);
        vinn <= 0.9240056077817997;
        delay(0);
        
        
        delay(1.1e-9);
        
        
        
        
        delay(1e-9);
        vinp <= 0.8933397804873966;
        delay(0);
        vinn <= 0.9221573681206567;
        delay(0);
        delay(1e-9);
        vinp <= 0.9234890874502335;
        delay(0);
        vinn <= 0.8920080611578198;
        delay(0);
        
        
        delay(1.1e-9);
        
        
        
        
        delay(1e-9);
        vinp <= 0.906901072032982;
        delay(0);
        vinn <= 0.9527152173145736;
        delay(0);
        delay(1e-9);
        vinp <= 0.9489066341569966;
        delay(0);
        vinn <= 0.910709655190559;
        delay(0);
        
        
        delay(1.1e-9);
        
        
        
        
        delay(1e-9);
        vinp <= 0.9009372343678432;
        delay(0);
        vinn <= 0.9459251122694354;
        delay(0);
        delay(1e-9);
        vinp <= 0.9380129186956297;
        delay(0);
        vinn <= 0.9088494279416489;
        delay(0);
        
        
        delay(1.1e-9);
        
        
        
        
        delay(1e-9);
        vinp <= 0.8928112170203896;
        delay(0);
        vinn <= 0.9422554627010974;
        delay(0);
        delay(1e-9);
        vinp <= 0.9424379175781705;
        delay(0);
        vinn <= 0.8926287621433164;
        delay(0);
        
        
        delay(1.1e-9);
        
        
        
        
        delay(1e-9);
        vinp <= 0.894944574576996;
        delay(0);
        vinn <= 0.9367065875380162;
        delay(0);
        delay(1e-9);
        vinp <= 0.9318559827075847;
        delay(0);
        vinn <= 0.8997951794074275;
        delay(0);
        
        
        delay(1.1e-9);
        
        
        
        
        delay(1e-9);
        vinp <= 0.9269231081217383;
        delay(0);
        vinn <= 0.9515288899218423;
        delay(0);
        delay(1e-9);
        vinp <= 0.9620637756887805;
        delay(0);
        vinn <= 0.9163882223548;
        delay(0);
        
        
        delay(1.1e-9);
        
        
        
        
        delay(1e-9);
        vinp <= 0.9313836253119102;
        delay(0);
        vinn <= 0.9371493936774561;
        delay(0);
        delay(1e-9);
        vinp <= 0.9575275635826831;
        delay(0);
        vinn <= 0.9110054554066832;
        delay(0);
        
        
        delay(1.1e-9);
        
        
        
        
        delay(1e-9);
        vinp <= 0.9293120321718616;
        delay(0);
        vinn <= 0.9681759204538148;
        delay(0);
        delay(1e-9);
        vinp <= 0.9706624730292346;
        delay(0);
        vinn <= 0.9268254795964419;
        delay(0);
        
        
        delay(1.1e-9);
        
        
        
        
        delay(1e-9);
        vinp <= 0.8964685874395859;
        delay(0);
        vinn <= 0.9432761648752286;
        delay(0);
        delay(1e-9);
        vinp <= 0.9291228400311056;
        delay(0);
        vinn <= 0.9106219122837089;
        delay(0);
        
        
        delay(1.1e-9);
        
        
        
        
        delay(1e-9);
        vinp <= 0.8760141674347892;
        delay(0);
        vinn <= 0.9240662325411049;
        delay(0);
        delay(1e-9);
        vinp <= 0.9248439413830467;
        delay(0);
        vinn <= 0.8752364585928474;
        delay(0);
        
        
        delay(1.1e-9);
        
        
        
        
        delay(1e-9);
        vinp <= 0.9229961814223785;
        delay(0);
        vinn <= 0.961637681555317;
        delay(0);
        delay(1e-9);
        vinp <= 0.9634914225105081;
        delay(0);
        vinn <= 0.9211424404671874;
        delay(0);
        
        
        delay(1.1e-9);
        
        
        
        
        delay(1e-9);
        vinp <= 0.9240902445162678;
        delay(0);
        vinn <= 0.9437836490721077;
        delay(0);
        delay(1e-9);
        vinp <= 0.9527418005870063;
        delay(0);
        vinn <= 0.9151320930013691;
        delay(0);
        
        
        delay(1.1e-9);
        
        
        
        
        delay(1e-9);
        vinp <= 0.9013067560203311;
        delay(0);
        vinn <= 0.9500182954858384;
        delay(0);
        delay(1e-9);
        vinp <= 0.9412345778032162;
        delay(0);
        vinn <= 0.9100904737029533;
        delay(0);
        
        
        delay(1.1e-9);
        
        
        
        
        delay(1e-9);
        vinp <= 0.9128276249739152;
        delay(0);
        vinn <= 0.9619867329690569;
        delay(0);
        delay(1e-9);
        vinp <= 0.9460579935787665;
        delay(0);
        vinn <= 0.9287563643642056;
        delay(0);
        
        
        delay(1.1e-9);
        
        
        
        
        delay(1e-9);
        vinp <= 0.8922369592256489;
        delay(0);
        vinn <= 0.9313591119521571;
        delay(0);
        delay(1e-9);
        vinp <= 0.9366376192634162;
        delay(0);
        vinn <= 0.8869584519143899;
        delay(0);
        
        
        delay(1.1e-9);
        
        
        
        
        delay(1e-9);
        vinp <= 0.8805631716320353;
        delay(0);
        vinn <= 0.9274895616179654;
        delay(0);
        delay(1e-9);
        vinp <= 0.9261033694325713;
        delay(0);
        vinn <= 0.8819493638174294;
        delay(0);
        
        
        delay(1.1e-9);

        $finish;
    end

endmodule
