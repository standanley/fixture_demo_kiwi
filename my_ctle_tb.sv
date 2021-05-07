// handmade tb

`timescale 1fs/1fs
`include "final.sv"

module my_ctle_tb;

    real inp, inn, v_fz, vdd, vss;
    real outn, outp;
    
    ctle DUT (.vinn(inn), .vinp(inp), .voutn(outn), .voutp(outp), .v_fz(v_fz), .vdd(vdd), .vss(vss));

    initial begin
        $dumpfile("waveforms.vcd");
        $dumpvars;
        vss = 0;
        vdd = 1.8;
        inn = 0.92;
        inp = 0.92;
        v_fz = 0.8;

        #(1e-9 * 1s);

        inp = 0.95;
        inn = 0.89;

        #(1e-9 * 1s);

        // go outside the v_fz spec
        v_fz = 0.1;

        #(1e-9 * 1s);

        // go inside the v_fz spec
        v_fz = 0.6;

        #(1e-9 * 1s);

        // go outside the v_fz spec
        v_fz = 1.7;

        #(1e-9 * 1s);

        // go inside the v_fz spec
        v_fz = 0.6;

        #(1e-9 * 1s);


        $finish;

    end


endmodule
