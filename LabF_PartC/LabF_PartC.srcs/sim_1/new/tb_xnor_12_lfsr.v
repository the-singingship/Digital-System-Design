`timescale 1ns/1ps
// File    : tb_xnor_12_lfsr.v
// Student : 25370745
// Purpose : Testbench for xnor_12_lfsr.v
//           max_tick expected at ~82,400ns and ~164,300ns

module tb_xnor_12_lfsr;

    reg clk;
    reg reset;
    wire [11:0] lfsr_reg;
    wire max_tick_reg;

    // instantiate LFSR
    xnor_12_lfsr uut(
        .clk(clk),
        .reset(reset),
        .lfsr_reg(lfsr_reg),
        .max_tick_reg(max_tick_reg)
    );

    // 20ns clock
    always #10 clk = ~clk;

    initial begin
        clk   = 0;
        reset = 1;
        #500  reset = 0;    // deassert reset after 500ns
        #200000 $finish;    
    end

endmodule