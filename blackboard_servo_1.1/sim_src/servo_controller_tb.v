
`timescale 1ns / 1ps

module servo_controller_tb();

    // Inputs
    reg clk_100M;
    reg rst;

    reg [7 : 0] angle;
    reg [3 : 0] speed;

    // Output
    wire out_sig;

    // 100 MHz clock gen
    initial   clk_100M = 1'b0;
    always #5 clk_100M <= ~clk_100M;

    servo_controller dut
    (
        .clk_100M ( clk_100M ),
        .rst      ( rst      ),
        .en       ( 1'b1     ),
        .angle    ( angle    ),
        .speed    ( speed    ),
        .out_sig  ( out_sig  )
    );

    initial begin : test

        rst = 1'b1;
        #50
        rst = 1'b0;
        
        speed = 4'd10;
        angle = 8'd90;

        #600000000
        $finish;

    end // test

endmodule // servo_controller_tb
