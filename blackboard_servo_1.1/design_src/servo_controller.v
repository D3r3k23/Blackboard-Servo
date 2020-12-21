
module servo_controller
(
    input  wire clk_100M, rst, en,
    input  wire [7 : 0] angle, // 0 - 180
    input  wire [6 : 0] speed, // 0 - 100
    output wire out_sig
);

    wire rotation_clk_div = (100 - speed) * 500000;
    wire rotation_clk;

    clk_divider rotation_clk_gen
    (
        .clk_in  ( clk_100M         ),
        .rst     ( rst              ),
        .clk_div ( rotation_clk_div ),
        .clk_out ( rotation_clk     )
    );

    wire [5 : 0] target_pulsewidth = angle / 6;
    reg  [4 : 0] pulsewidth;

    always @( posedge rotation_clk )
    begin
        if (rst)
            pulsewidth <= 0;
        else
        begin
            if      (pulsewidth < pulsewidth_target) pulsewidth <= pulsewidth + 1;
            else if (pulsewidth > pulsewidth_target) pulsewidth <= pulsewidth - 1;
            else                                     pulsewidth <= pulsewidth;
        end
    end

    wire pwm_clk;

    clk_divider pwm_clk_gen
    (
        .clk_in  ( clk_100M ),
        .rst     ( rst      ),
        .clk_div ( 62500    ), // 1.6 kHz pwm frequency - 20 ms period, 5 bit resolution
        .clk_out ( pwm_clk  )
    );

    pwm #( .RES(5) )
    sig_gen
    (
        .clk        ( pwm_clk    ),
        .rst        ( rst        ),
        .en         ( en         ),
        .pulsewidth ( pulsewidth ),
        .period     ( 5'd32      ),
        .pwm_sig    ( out_sig    )
    );

endmodule
