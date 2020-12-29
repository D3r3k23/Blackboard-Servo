
module pwm
(
    input  wire          clk, rst, en,
    input  wire [11 : 0] period,
    input  wire [11 : 0] pulsewidth,
    output wire          pwm_sig
);
    
    reg [11 : 0] pulse_count = 0;

    always @( posedge clk )
    begin
        if (rst || (pulse_count == period))
            pulse_count <= 0;
        else
            pulse_count <= pulse_count + 1;
    end

    assign pwm_sig = ~rst & en & (pulse_count < pulsewidth);

endmodule // pwm
