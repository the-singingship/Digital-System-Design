`timescale 1ns / 1ps
// ============================================================
// adder.v  -  1-bit Full Adder (structural primitive)
// Used as the building block inside adder_subtractor.v
//
// Ports:
//   a, b  : 1-bit operand inputs
//   cin   : carry-in
//   sum   : 1-bit sum output
//   cout  : carry-out
// ============================================================

module adder(
    input  a,
    input  b,
    input  cin,
    output sum,
    output cout
);

    assign sum  = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (a & cin);

endmodule