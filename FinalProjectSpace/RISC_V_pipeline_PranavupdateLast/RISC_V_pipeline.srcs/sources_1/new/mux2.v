`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2024 11:49:14 PM
// Design Name: 
// Module Name: mux2
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
module mux2(
  input wire [63:0] in1, wire [63:0] in2, wire [63:0]  in3, wire [1:0] sel,
  output wire [63:0] out
);
  wire [63:0] tempResult;
  mux m1 (.in1(in1), .in2(in2), .sel(sel[0]), .out(tempResult));
  mux m2 (.in1(tempResult), .in2(in3), .sel(sel[1]), .out(out));
endmodule 


