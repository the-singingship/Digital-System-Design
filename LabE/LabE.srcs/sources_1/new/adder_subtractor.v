`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.03.2026 01:38:34
// Design Name: 
// Module Name: adder_subtractor
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


module adder_subtractor(
    input  [3:0] a,
    input  [3:0] b,
    input        sub,
    output [3:0] sum,
    output       cout,
    output       ovfl
);

    // When sub=1, invert every bit of b (XOR with 1)
    // When sub=0, leave b unchanged (XOR with 0)
    wire [3:0] b_op;
    assign b_op = b ^ {4{sub}};

    // Internal carry chain
    wire c0, c1, c2;   // carries between stages

    // Bit 0  -  carry-in is sub (=1 for subtraction, completing two's complement)
    adder fa0 (.a(a[0]), .b(b_op[0]), .cin(sub),  .sum(sum[0]), .cout(c0));
    adder fa1 (.a(a[1]), .b(b_op[1]), .cin(c0),   .sum(sum[1]), .cout(c1));
    adder fa2 (.a(a[2]), .b(b_op[2]), .cin(c1),   .sum(sum[2]), .cout(c2));
    adder fa3 (.a(a[3]), .b(b_op[3]), .cin(c2),   .sum(sum[3]), .cout(cout));

    // Overflow: signed overflow occurs when the carry INTO the MSB
    // differs from the carry OUT OF the MSB.
    //   carry into MSB  = c2
    //   carry out of MSB = cout
    assign ovfl = c2 ^ cout;

endmodule