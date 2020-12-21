
module clk_divider
(
    input  wire clk_in,
    input  wire rst,
    input  wire clk_div,
    output reg  clk_out
);
    reg [31 : 0] TC = (clk_div >= 2) ? ((clk_div / 2) - 1) : 0;
    reg [31 : 0] count;

    wire terminate = (count >= TC);

    always @( posedge clk_in )
    begin
        if (rst | terminate)
            count <= 0;
        else
            count <= count + 1;

        if (rst)
            clk_out <= 0;
        else if (terminate)
            clk_out <= ~clk_out;
    end

endmodule
