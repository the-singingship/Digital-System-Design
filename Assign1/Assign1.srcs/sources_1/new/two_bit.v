`timescale 1ns / 1ps

// File    : two_bit.v
// Student : 25370745
// Purpose : Gate-level 2-bit comparator building blocks.
//           gt2 - greater-than (a > b)
//           eq2 - equality    (a == b)
//           Both instantiated by gte8 in eight_bit.v

module gt2 (
    input  wire [1:0] a, b,
    output wire       agtb
);
    // MSB dominates; equal MSBs resolved by LSB
    assign agtb = (a[1] & ~b[1]) | (~(a[1] ^ b[1]) & a[0] & ~b[0]);
endmodule

// 2-bit equality comparator
// aeqb=1 when a == b
module eq2 (
    input  wire [1:0] a, b,
    output wire       aeqb
);
    // both bit positions must match
    assign aeqb = ~(a[0] ^ b[0]) & ~(a[1] ^ b[1]);
endmodule