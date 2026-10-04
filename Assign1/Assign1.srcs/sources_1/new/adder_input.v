`timescale 1ns / 1ps

// File    : adder_input.v
// Student : 25370745
// Purpose : Selects correct operands and mode for
//           ripple_adder_6bit based on the ALU fxn code.
//
//   fxn=000 (A)   : x_out=A,   y_out=B, sel_out=0  →  passes A (adder unused)
//   fxn=001 (B)   : x_out=A,   y_out=B, sel_out=0  →  passes B (adder unused)
//   fxn=010 (-A)  : x_out=0,   y_out=A, sel_out=1  →  0 - A = -A
//   fxn=011 (-B)  : x_out=0,   y_out=B, sel_out=1  →  0 - B = -B
//   fxn=100 (A<B) : x_out=A,   y_out=B, sel_out=0  →  passes to less_than (adder unused)
//   fxn=101 (XNOR): x_out=A,   y_out=B, sel_out=0  →  passes to xnor unit (adder unused)
//   fxn=110 (A+B) : x_out=A,   y_out=B, sel_out=0  →  A + B
//   fxn=111 (A-B) : x_out=A,   y_out=B, sel_out=1  →  A - B

module adder_input (
    input  wire [5:0] A, B,
    input  wire [2:0] fxn,
    output wire [5:0] x_out,
    output wire [5:0] y_out,
    output wire       sel_out
);
    // x is zero for negation operations, A for all others
    assign x_out   = ((fxn == 3'b010) || (fxn == 3'b011)) ? 6'b000000 : A;

    // y is A when computing -A, B in all other cases
    assign y_out   = (fxn == 3'b010) ? A : B;

    // sel=1 activates subtraction/negation mode
    assign sel_out = ((fxn == 3'b010) || (fxn == 3'b011) || (fxn == 3'b111)) ? 1'b1 : 1'b0;
endmodule
