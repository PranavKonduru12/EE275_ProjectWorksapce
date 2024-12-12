`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2024 11:25:17 PM
// Design Name: 
// Module Name: Adder
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
//Consists of both FPU and Adder, differentiates between floating point and integer
module Adder(
  input wire [63:0] a,          // Integer input 1
  input wire [63:0] b,          // Integer input 2
  input wire [31:0] floatA,     // Floating-point input 1
  input wire [31:0] floatB,     // Floating-point input 2
  input wire isFloat,           // Data type selector: 1 = Floating-point, 0 = Integer
  output wire [63:0] out,       // Output result
  output wire [31:0] floatOut   // Floating-point output (optional for debugging)
);

  // Integer addition
  wire [63:0] intSum;
  assign intSum = a + b;

  // Floating-point addition using the FPU
  wire [31:0] fpuSum;
  wire fpuException;
  FPU fpu (
    .opA(floatA),
    .opB(floatB),
    .FADD_FSUB(1'b0), // Perform addition
    .result(fpuSum),
    .exception(fpuException) // Exception flag (not used here)
  );

  // Output selection
  assign out = isFloat ? {32'b0, fpuSum} : intSum; // Zero-extend floating-point result
  assign floatOut = fpuSum; // Optional output for debugging floating-point results

endmodule
//module Adder(
//  input wire [63:0] a, b,
//  output wire [63:0] out
//);
//  assign out = a + b;
//endmodule 


