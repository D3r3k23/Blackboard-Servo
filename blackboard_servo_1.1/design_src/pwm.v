
module pwm
(
    input  wire          clk,
    input  wire          rst,
    input  wire          en,
    input  wire [11 : 0] period,
    input  wire [11 : 0] pulsewidth,
    output wire          pwm_sig
);
    
    reg [11 : 0] pulse_count = 0;

    always @( posedge clk )
        if (rst || (pulse_count == period))
            pulse_count <= 0;
        else
            pulse_count <= pulse_count + 1;

    assign pwm_sig = ~rst & en & (pulse_count < pulsewidth);

endmodule // pwm
