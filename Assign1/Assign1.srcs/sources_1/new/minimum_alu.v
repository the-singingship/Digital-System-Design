`timescale 1ns / 1ps

// File    : minimum_alu.v
// Student : 25370745
// Purpose : Top-level 6-bit Mini ALU.
//           Contains ONLY module instantiations - no logic.
//           All sub-modules wired together here.
// Function table:
//   fxn=000 : X = A
//   fxn=001 : X = B
//   fxn=010 : X = -A
//   fxn=011 : X = -B
//   fxn=100 : X = A < B  (signed, output 0 or 1)
//   fxn=101 : X = A XNOR B (bitwise)
//   fxn=110 : X = A + B
//   fxn=111 : X = A - B

module minimum_alu (
    input  wire [5:0] A,
    input  wire [5:0] B,
    input  wire [2:0] fxn,
    output wire [5:0] X
);
    // internal connection wires
    wire [5:0] adder_x_in;     // x operand fed into ripple adder
    wire [5:0] adder_y_in;     // y operand fed into ripple adder
    wire       adder_sel;      // add/subtract select for ripple adder
    wire [5:0] adder_out;      // sum result from ripple adder
    wire       adder_cout;     // carry out (unused at top level)
    wire       adder_overflow; // overflow flag (unused at top level)
    wire [5:0] less_than_out;  // signed A < B comparison result
    wire [5:0] xnor_out;       // bitwise A XNOR B result

    // select correct operands and mode for the adder
    adder_input sel_unit (
        .A       (A),
        .B       (B),
        .fxn     (fxn),
        .x_out   (adder_x_in),
        .y_out   (adder_y_in),
        .sel_out (adder_sel)
    );

    // 6-bit ripple carry adder/subtractor (reused from Lab C)
    ripple_adder_6bit adder_unit (
        .x        (adder_x_in),
        .y        (adder_y_in),
        .sel      (adder_sel),
        .sum      (adder_out),
        .c_out    (adder_cout),
        .overflow (adder_overflow)
    );

    // signed less-than using 8-bit gte8 unmodified
    less_than_six_bit lt_unit (
        .A      (A),
        .B      (B),
        .result (less_than_out)
    );

    // bitwise 6-bit XNOR module
    six_bit_xnor xnor_unit (
        .A      (A),
        .B      (B),
        .result (xnor_out)
    );

    // select correct result based on fxn
    multiplexer_output mux_unit (
        .A             (A),
        .B             (B),
        .adder_out     (adder_out),
        .less_than_out (less_than_out),
        .xnor_out      (xnor_out),
        .fxn           (fxn),
        .X             (X)
    );

endmodule
