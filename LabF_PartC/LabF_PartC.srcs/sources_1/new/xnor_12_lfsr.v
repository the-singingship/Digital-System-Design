`timescale 1ns/1ps
// File    : xnor_12_lfsr.v
// Student : 25370745
// Purpose : 12-bit XNOR LFSR, seed=12'hD42
//           Taps: 12,6,4,1 | Sequence: 2^12-1 = 4095 cycles

module xnor_12_lfsr(
    input clk,                      // clock input
    input reset,                    // active high async reset
    output reg [11:0] lfsr_reg,     // 12-bit LFSR state
    output reg max_tick_reg         // high for 1 cycle when sequence completes
);
    // seed = XOR of board no. (0x054) and last 3 ID digits (0x2E9) = 0x2BD
    localparam SEED = 12'h2BD;

    // XNOR feedback: taps 12,6,4,1 → 0-indexed bits 0,6,8,11
    wire feedback;
    assign feedback = ~(lfsr_reg[0] ^ lfsr_reg[6] ^
                        lfsr_reg[8] ^ lfsr_reg[11]);

    // next LFSR state: shift left, insert feedback at LSB
    wire [11:0] next_lfsr;
    assign next_lfsr = {lfsr_reg[10:0], feedback};

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            lfsr_reg     <= SEED;   // load seed on reset
            max_tick_reg <= 1'b0;
        end else begin
            lfsr_reg     <= next_lfsr;
            // assert max_tick for 1 cycle when sequence completes
            max_tick_reg <= (next_lfsr == SEED) ? 1'b1 : 1'b0;
        end
    end
endmodule