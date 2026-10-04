`timescale 1ns / 1ps

// File    : less_than_six_bit.v
// Student : 25370745
// Purpose : Signed 6-bit less-than comparator (A < B).
//           Uses gte8 at full 8-bit width WITHOUT modification.
//           Trick: flipping the MSB of each input converts
//           2's complement to offset binary, so the unsigned
//           gte8 correctly handles signed comparison.
//           Inputs are zero-extended to 8 bits for gte8.
// Output  : result = 6'b000001 if A < B, else 6'b000000

module less_than_six_bit (
    input  wire [5:0] A, B,
    output wire [5:0] result
);
//  (flip MSB for signed comparison)

   // internal 8-bit sign-converted inputs flip MSB and zero-extend
    wire [7:0] a_conv, b_conv;
    // wire for gte8 output  
    wire       agteb;

    // flip MSB for sign conversion, zero-extend upper bits
    assign a_conv = {1'b0, ~A[5], A[4:0]};
    assign b_conv = {1'b0, ~B[5], B[4:0]};

    // reuse 8-bit comparator unchanged
    gt_8bit comparator (.a(a_conv), .b(b_conv), .agteb(agteb));

    // A < B is the logical inverse of A >= B
    assign result = {5'b00000, ~agteb};
endmodule