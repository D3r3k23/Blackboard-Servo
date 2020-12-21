
`timescale 1ns / 1ps

module pwm_tb();

    reg  clk_100M = 1'b0;
    reg  rst      = 1'b1;

    wire pwm_sig;

    always #5 clk_100M <= ~clk_100M;

    pwm
    #(
        .CLK_DIV( 2000000 ),
        .WIDTH  ( 8       )
    )
    dut
    (
        .clk        ( clk_100M ),
        .rst        ( rst      ),
        .en         ( 1'b1     ),
        .pulsewidth ( 8'd100   ),
        .pwm_sig    ( pwm_sig  )
    );

    initial
    begin
        #50 rst <= 1'b0;
    end

endmodule
