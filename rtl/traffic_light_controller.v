module traffic_light_controller(

    input wire clk,
    input wire reset,

    output reg A_red,
    output reg A_yellow,
    output reg A_green,

    output reg B_red,
    output reg B_yellow,
    output reg B_green

);

parameter GREEN_TIME  = 5;
parameter YELLOW_TIME = 2;

localparam S0 = 2'b00;
localparam S1 = 2'b01;
localparam S2 = 2'b10;
localparam S3 = 2'b11;

reg [1:0] current_state;
reg [1:0] next_state;
reg [3:0] timer;

always @(posedge clk) begin

    if(reset) begin
        current_state <= S0;
        timer <= 0;
    end
    else begin

        current_state <= next_state;

        if(current_state != next_state)
            timer <= 0;
        else
            timer <= timer + 1;

    end

end

always @(*) begin

    next_state = current_state;

    case(current_state)

        S0:
            if(timer == GREEN_TIME-1)
                next_state = S1;

        S1:
            if(timer == YELLOW_TIME-1)
                next_state = S2;

        S2:
            if(timer == GREEN_TIME-1)
                next_state = S3;

        S3:
            if(timer == YELLOW_TIME-1)
                next_state = S0;

        default:
            next_state = S0;

    endcase

end

always @(*) begin

    A_red = 0;
    A_yellow = 0;
    A_green = 0;

    B_red = 0;
    B_yellow = 0;
    B_green = 0;

    case(current_state)

        S0: begin
            A_green = 1;
            B_red = 1;
        end

        S1: begin
            A_yellow = 1;
            B_red = 1;
        end

        S2: begin
            A_red = 1;
            B_green = 1;
        end

        S3: begin
            A_red = 1;
            B_yellow = 1;
        end

        default: begin
            A_green = 1;
            B_red = 1;
        end

    endcase

end

endmodule