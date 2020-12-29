
module servo_controller
(
    input  wire         clk_100M,
    input  wire         rst,
    input  wire         en,
    input  wire [7 : 0] angle, // 0 - 180
    input  wire [3 : 0] speed, // 0 - 10
    output wire         out_sig
);

    localparam integer MIN_PW = 70;
    localparam integer MAX_PW = 230;

    wire rotation_clk;

    clk_divider rotation_clk_gen
    (
        .clk_in  ( clk_100M     ),
        .rst     ( rst          ),
        .clk_div ( 5000000      ), // 20 Hz
        .clk_out ( rotation_clk )
    );

    wire [11 : 0] target_pulsewidth = (angle * 8) / 9 + MIN_PW; // 70 - 230 (angle: 0 - 180)
    reg  [11 : 0] pulsewidth = 0;

    always @( posedge rotation_clk )
        if (rst)
            pulsewidth <= 0;
        else
        begin
            if (speed == 0)
                pulsewidth <= pulsewidth;

            else if (pulsewidth < MIN_PW) pulsewidth <= MIN_PW;
            else if (pulsewidth > MAX_PW) pulsewidth <= MAX_PW;
        
            else if (((target_pulsewidth - speed) <= pulsewidth) && (pulsewidth <= (target_pulsewidth + speed)))
                pulsewidth <= target_pulsewidth;

            else if (pulsewidth < target_pulsewidth) pulsewidth <= pulsewidth + speed;
            else if (pulsewidth > target_pulsewidth) pulsewidth <= pulsewidth - speed;
            
            else
                pulsewidth <= pulsewidth;
        end

    wire pwm_clk;

    clk_divider pwm_clk_gen
    (
        .clk_in  ( clk_100M ),
        .rst     ( rst      ),
        .clk_div ( 1000     ), // 100 kHz pwm frequency
        .clk_out ( pwm_clk  )
    );

    pwm sig_gen
    (
        .clk        ( pwm_clk    ), // 100 kHz | 10 us period
        .rst        ( rst        ),
        .en         ( en         ),
        .period     ( 12'd2000   ), // PWM signal period: 20 ms
        .pulsewidth ( pulsewidth ), // 70 - 230 | 700 - 2300 us
        .pwm_sig    ( out_sig    )
    );

endmodule // servo_controller
