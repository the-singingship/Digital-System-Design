`timescale 1ns / 1ps

// File    : multiplexer_output.v
// Student : 25370745
// Purpose : 8-to-1 output multiplexer for minimum_alu.
//           Routes the correct computed result to output X
//           based on 3-bit function select fxn.
//   fxn=010 → X = adder_out       (-A result)
//   fxn=011 → X = adder_out       (-B result)
//   fxn=110 → X = adder_out       (A + B result)
//   fxn=111 → X = adder_out       (A - B result)

module multiplexer_output (
    input  wire [5:0] A,
    input  wire [5:0] B,
    input  wire [5:0] adder_out,
    input  wire [5:0] less_than_out,
    input  wire [5:0] xnor_out,
    input  wire [2:0] fxn,
    output wire [5:0] X
);
    assign X = (fxn == 3'b000) ? A             :
               (fxn == 3'b001) ? B             :
               (fxn == 3'b010) ? adder_out     :
               (fxn == 3'b011) ? adder_out     :
               (fxn == 3'b100) ? less_than_out :
               (fxn == 3'b101) ? xnor_out      :
               (fxn == 3'b110) ? adder_out     :
               (fxn == 3'b111) ? adder_out     :
               6'b000000;
endmodule