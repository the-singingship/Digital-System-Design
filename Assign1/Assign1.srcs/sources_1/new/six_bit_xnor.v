`timescale 1ns / 1ps

// File    : six_bit_xnor.v
// Student : 25370745
// Purpose : Bitwise 6-bit XNOR operation.
//           All-1s when A == B, all-0s when every bit differs.
// Output  : result[5:0] where each bit = ~(A[i] ^ B[i])

module six_bit_xnor (
    input  wire [5:0] A, B,
    output wire [5:0] result
);
    // invert XOR to produce XNOR across all 6 bit positions
    assign result = ~(A ^ B);
endmodule