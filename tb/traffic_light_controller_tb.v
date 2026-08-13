`timescale 1ns/1ps

module traffic_light_controller_tb;

reg clk;
reg reset;

wire A_red;
wire A_yellow;
wire A_green;

wire B_red;
wire B_yellow;
wire B_green;

traffic_light_controller #(
    .GREEN_TIME(5),
    .YELLOW_TIME(2)
) dut (

    .clk(clk),
    .reset(reset),

    .A_red(A_red),
    .A_yellow(A_yellow),
    .A_green(A_green),

    .B_red(B_red),
    .B_yellow(B_yellow),
    .B_green(B_green)

);

initial
    clk = 0;

always #5 clk = ~clk;

initial begin

    $dumpfile("traffic_light.vcd");
    $dumpvars(0, traffic_light_controller_tb);

    reset = 1;

    #15;
    reset = 0;

    #250;

    $finish;

end

initial begin

    $display("Time\tState\tTimer\tA(RYG)\tB(RYG)");

    $monitor("%0t\t%0d\t%0d\t%b%b%b\t%b%b%b",

        $time,
        dut.current_state,
        dut.timer,

        A_red,
        A_yellow,
        A_green,

        B_red,
        B_yellow,
        B_green

    );

end

endmodule