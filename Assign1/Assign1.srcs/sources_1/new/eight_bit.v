`timescale 1ns / 1ps

// File    : eight_bit.v
// Student : 25370745
// Purpose : 8-bit greater-than-or-equal comparator.
//           Built from four gt2 and four eq2 blocks (two_bit.v).
//           Used at full 8-bit width by less_than_six_bit.v
//           via MSB-flip sign conversion - NOT reduced to 6 bits.
//           Built from 2-bit gt and eq modules as building blocks
// Output  : agteb=1 when a >= b

module gt_8bit (
    input  wire [7:0] a, b,
    output wire       agteb
);
    // greater-than and equality result wires
    wire gt3, gt2_out, gt1, gt0;
    wire eq3, eq2_out, eq1_out, eq0;

    // 2-bit greater-than block per 2-bit slice
    gt2 gt_block3 (.a(a[7:6]), .b(b[7:6]), .agtb(gt3));
    gt2 gt_block2 (.a(a[5:4]), .b(b[5:4]), .agtb(gt2_out));
    gt2 gt_block1 (.a(a[3:2]), .b(b[3:2]), .agtb(gt1));
    gt2 gt_block0 (.a(a[1:0]), .b(b[1:0]), .agtb(gt0));

    // 2-bit equality block per 2-bit slice
    eq2 eq_block3 (.a(a[7:6]), .b(b[7:6]), .aeqb(eq3));
    eq2 eq_block2 (.a(a[5:4]), .b(b[5:4]), .aeqb(eq2_out));
    eq2 eq_block1 (.a(a[3:2]), .b(b[3:2]), .aeqb(eq1_out));
    eq2 eq_block0 (.a(a[1:0]), .b(b[1:0]), .aeqb(eq0));

    // A >= B when any of the following conditions is true:
    // block3 is greater than block3 of B
    // block3 is equal and block2 is greater
    // block3 and block2 are equal and block1 is greater
    // block3, block2, and block1 are equal and block0 is greater
    // all blocks are equal
    assign agteb = gt3                             |
                   (eq3 & gt2_out)                 |
                   (eq3 & eq2_out & gt1)           |
                   (eq3 & eq2_out & eq1_out & gt0) |
                   (eq3 & eq2_out & eq1_out & eq0);
endmodule