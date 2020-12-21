
module pwm
#(parameter
    integer RES = 8
)(
    input wire clk, rst, en,

    input wire [RES - 1 : 0] pulsewidth,
    input wire [RES - 1 : 0] period,

    output wire pwm_sig
);
    
    reg [RES - 1 : 0] count;

    always @( posedge pwm_clk )
    begin
        if (rst | (count == period))
            count <= 0;
        else
            count <= count + 1;
    end

    assign pwm_sig = (~rst & en) & (count < pulsewidth);

endmodule
