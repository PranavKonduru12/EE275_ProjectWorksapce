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
  input wire [63:0] in1,            // Integer input 1
  input wire [63:0] in2,            // Integer input 2
  input wire [63:0] in3,            // Integer input 3
  input wire [31:0] floatIn1,       // Floating-point input 1
  input wire [31:0] floatIn2,       // Floating-point input 2
  input wire [31:0] floatIn3,       // Floating-point input 3
  input wire [1:0] sel,             // Selector signal
  input wire isFloat,               // Data type selector: 1 = Floating-point, 0 = Integer
  output wire [63:0] out            // Output
);

  wire [63:0] tempResult;

  // First stage: select between in1 and in2 or floatIn1 and floatIn2
  mux m1 (
    .in1(in1), 
    .in2(in2), 
    .floatIn1(floatIn1), 
    .floatIn2(floatIn2), 
    .sel(sel[0]), 
    .isFloat(isFloat), 
    .out(tempResult)
  );

  // Second stage: select between tempResult and in3 or floatIn3
  mux m2 (
    .in1(tempResult), 
    .in2(in3), 
    .floatIn1(tempResult[31:0]), 
    .floatIn2(floatIn3), 
    .sel(sel[1]), 
    .isFloat(isFloat), 
    .out(out)
  );

endmodule

//module mux2(
//  input wire [63:0] in1, wire [63:0] in2, wire [63:0]  in3, wire [1:0] sel,
//  output wire [63:0] out
//);
//  wire [63:0] tempResult;
//  mux m1 (.in1(in1), .in2(in2), .sel(sel[0]), .out(tempResult));
//  mux m2 (.in1(tempResult), .in2(in3), .sel(sel[1]), .out(out));
//endmodule 


