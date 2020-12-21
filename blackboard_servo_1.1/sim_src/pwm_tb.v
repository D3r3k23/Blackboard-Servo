
`timescale 1ns / 1ps

module pwm_tb();

    reg  clk_1_6k = 1'b0;
    reg  rst      = 1'b1;

    wire pwm_sig;

    always # clk_1_6k <= ~clk_1_6k;

    pwm #( .RES(5) )
    dut
    (
        .clk        ( clk_1_6k ),
        .rst        ( rst      ),
        .en         ( 1'b1     ),
        .pulsewidth ( 5'd25    ),
        .period     ( 5'd32    ),
        .pwm_sig    ( pwm_sig  )
    );

    initial
    begin
        #50 rst <= 1'b0;
    end

endmodule
