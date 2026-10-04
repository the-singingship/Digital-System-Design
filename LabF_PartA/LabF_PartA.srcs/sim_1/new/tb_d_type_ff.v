`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.03.2026 21:19:02
// Design Name: 
// Module Name: tb_d_type_ff
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// File    : tb_d_type_ff.v
// Student : 25370745
// Purpose : Testbench for d_type_ff.v
//          Tests: list what is being tested
module tb_d_type_ff;

    reg clk, reset, d;
    wire q;

    // instantiate the DFF module
    d_ff_reset uut (
        .clk(clk),
        .reset(reset),
        .d(d),
        .q(q)
    );

    // clock: 20ns period
    initial clk = 0;
    always #10 clk = ~clk;

    // reset signal
    initial begin
        reset = 1;
        #35 reset = 0;
        #100 reset = 1;
        #20  reset = 0;
        #200;
    end

    // test vector for d
    // d goes high after reset falls, then follows clock-aligned changes
    initial begin
    d = 0;
    #40  d = 1;  // goes high after reset deasserts
    #20  d = 0;  // falls after one clock cycle
    #40  d = 1;  // goes high again
    #60  d = 0;  // falls
    #80  d = 1;  // goes high for longer stretch
    #60  d = 0;
    #200 $finish;
    end

endmodule
