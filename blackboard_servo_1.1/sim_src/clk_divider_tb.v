
`timescale 1ns / 1ps

module clk_divider_tb();

    reg  clk_100M = 1'b0;
    reg  rst      = 1'b1;

    wire clk_out;

    always #5 clk_100M <= ~clk_100M;

    clk_divider #( .DIV(62500))
    dut
    (
        .clk_in  ( clk_100M ),
        .rst     ( rst      ),
        .clk_out ( clk_out  )
    );

    initial
    begin
        #50 rst <= 1'b0;
    end

endmodule
