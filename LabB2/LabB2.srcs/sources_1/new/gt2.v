`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.02.2026 15:19:37
// Design Name: 
// Module Name: gt2
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


`timescale 1ns/10ps

module gt2(
  input [1:0] a,
  input [1:0] b,
  output agtb
);

assign agtb = (a[1] & ~b[1]) |
              (~(a[1]^b[1]) & a[0] & ~b[0]);

endmodule


