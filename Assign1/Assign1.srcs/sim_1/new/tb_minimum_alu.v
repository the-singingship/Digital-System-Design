`timescale 1ns / 1ps

// File : tb_minimum_alu.v
// Student ID: 25370745
// Board Number: 84 (7-bit: 1010100)
// First test vector uses last 6 bits of board number as per assignment requirement: 20 (6-bit: 010100

module tb_minimum_alu;
   reg [5:0] A, B;
   reg [2:0] fxn;
   wire [5:0] X;
   minimum_alu test (
      .A(A),
      .B(B),
      .fxn(fxn),
      .X(X)
   );
   initial
      $monitor("Time=%0t | fxn=%b | A=%b (%0d) | B=%b (%0d) | X=%b (%0d)",
               $time, fxn, A, $signed(A), B, $signed(B), X, $signed(X));
   initial
   begin
         // fxn=000: X = A (pass through A)
        A = 6'b010100; B = 6'b010101; fxn = 3'b000; #200; // TV1:  A=20,  B=21,  expect X=20
        A = 6'b011100; B = 6'b111000; fxn = 3'b000; #200; // TV2:  A=28,  B=-8,  expect X=28
        A = 6'b000000; B = 6'b111111; fxn = 3'b000; #200; // TV3:  A=0,   B=-1,  expect X=0

        // fxn=001: X = B (pass through B)
        A = 6'b101010; B = 6'b011011; fxn = 3'b001; #200; // TV4:  A=-22, B=27,  expect X=27
        A = 6'b111111; B = 6'b000000; fxn = 3'b001; #200; // TV5:  A=-1,  B=0,   expect X=0

        // fxn=010: X = -A (negate A)
        A = 6'b001100; B = 6'b000000; fxn = 3'b010; #200; // TV6:  A=12,  B=0,   expect X=-12
        A = 6'b100000; B = 6'b000000; fxn = 3'b010; #200; // TV7:  A=-32, B=0,   expect X=-32 (edge case overflow)

        // fxn=011: X = -B (negate B)
        A = 6'b000000; B = 6'b001100; fxn = 3'b011; #200; // TV8:  A=0,   B=12,  expect X=-12
        A = 6'b000000; B = 6'b100000; fxn = 3'b011; #200; // TV9:  A=0,   B=-32, expect X=-32 (edge case overflow)

        // fxn=100: X = A<B (signed less than)
        A = 6'b110000; B = 6'b110001; fxn = 3'b100; #200; // TV10: A=-16, B=-15, expect X=1  (true)
        A = 6'b001010; B = 6'b001010; fxn = 3'b100; #200; // TV11: A=10,  B=10,  expect X=0  (false, equal)
        A = 6'b100001; B = 6'b011111; fxn = 3'b100; #200; // TV12: A=-31, B=31,  expect X=1  (true)

        // -fxn=101: X = A XNOR B 
        A = 6'b100100; B = 6'b100100; fxn = 3'b101; #200; // TV13: A=-28, B=-28, expect X=-1  (all bits match)
        A = 6'b100100; B = 6'b011011; fxn = 3'b101; #200; // TV14: A=-28, B=27,  expect X=0   (all bits opposite)
        A = 6'b110100; B = 6'b100110; fxn = 3'b101; #200; // TV15: A=-12, B=-26, expect X=49  (mixed)

        // fxn=110: X = A+B (addition)
        A = 6'b001000; B = 6'b000111; fxn = 3'b110; #200; // TV16: A=8,   B=7,   expect X=15
        A = 6'b011111; B = 6'b000001; fxn = 3'b110; #200; // TV17: A=31,  B=1,   expect X=-32 (overflow)
        A = 6'b111111; B = 6'b111111; fxn = 3'b110; #200; // TV18: A=-1,  B=-1,  expect X=-2

        // fxn=111: X = A-B (subtraction)
        A = 6'b011111; B = 6'b011111; fxn = 3'b111; #200; // TV19: A=31,  B=31,  expect X=0
        A = 6'b000000; B = 6'b000001; fxn = 3'b111; #200; // TV20: A=0,   B=1,   expect X=-1
        A = 6'b100001; B = 6'b111111; fxn = 3'b111; #200; // TV21: A=-31, B=-1,  expect X=-30

      $stop;
   end
endmodule
