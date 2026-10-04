`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.03.2026 01:40:14
// Design Name: 
// Module Name: tb_adder_subtractor
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_adder_subtractor;

    reg  [3:0] a, b;
    reg        sub;
    wire [3:0] sum;
    wire       cout;
    wire       ovfl;

    adder_subtractor test_adder (
        .a(a),
        .b(b),
        .sub(sub),
        .sum(sum),
        .cout(cout),
        .ovfl(ovfl)
    );

    initial begin
    
        // --- Addition tests ---
        a = 4'b1001;  b = 4'b0011;  sub = 0; #10;   // 9 + 3 = 12
        a = 4'b1110;  b = 4'b0011;  sub = 0; #10;   // 14 + 3 = 17 (sum=1, carry=1)
        
        // --- Subtraction tests ---
        a = 4'b1010;  b = 4'b0011;  sub = 1; #10;   // 10 - 3 = 7
        a = 4'b0011;  b = 4'b0011;  sub = 1; #10;   // 3 - 3 = 0

        $finish;
    end

endmodule