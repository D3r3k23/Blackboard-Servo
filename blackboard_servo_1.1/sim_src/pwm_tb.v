
`timescale 1us / 1ns

module pwm_tb();

    // Inputs
    reg pwm_clk;
    reg rst;

    reg [11 : 0] pulsewidth;

    // Output
    wire pwm_sig;

    // 100 kHz clock gen
    initial   pwm_clk = 1'b0;
    always #5 pwm_clk <= ~pwm_clk;

    pwm dut
    (
        .clk        ( pwm_clk    ),
        .rst        ( rst        ),
        .en         ( 1'b1       ),
        .period     ( 12'd2000   ),
        .pulsewidth ( pulsewidth ),
        .pwm_sig    ( pwm_sig    )
    );

    initial begin : test

        rst = 1'b1;
        pulsewidth = 12'd100;
        #50
        rst = 1'b0;

        #90000
        pulsewidth = 12'd150;
        #90000
        pulsewidth = 12'd200;

        #90000
        $finish;

    end // test

endmodule // pwm_tb
