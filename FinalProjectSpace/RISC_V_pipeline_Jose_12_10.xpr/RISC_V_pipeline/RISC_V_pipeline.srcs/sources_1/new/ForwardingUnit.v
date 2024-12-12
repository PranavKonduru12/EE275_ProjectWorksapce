`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2024 11:40:36 PM
// Design Name: 
// Module Name: ForwardingUnit
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
module ForwardingUnit(
  input wire [4:0] rdMem,        // Destination register in MEM stage
  input wire regWriteMem,        // Write-back enable in MEM stage
  input wire [4:0] rdWb,         // Destination register in WB stage
  input wire regWriteWb,         // Write-back enable in WB stage
  input wire [4:0] rs1,          // Source register 1 in EX stage
  input wire [4:0] rs2,          // Source register 2 in EX stage
  input wire FPUEnable,          // Indicates if FPU operation is active
  output reg [1:0] ForwardA,     // Forwarding control for ALU/FPU input A
  output reg [1:0] ForwardB      // Forwarding control for ALU/FPU input B
);

  always @(*) begin
    // Default ForwardB
    if (regWriteMem && (rdMem !== 5'b0) && (rdMem === rs2)) begin
      ForwardB = FPUEnable ? 2'b11 : 2'b10; // Forward FPU result (2'b11) or ALU result (2'b10)
    end else if (regWriteWb && (rdWb !== 5'b0) && (rdWb === rs2)) begin
      ForwardB = FPUEnable ? 2'b01 : 2'b01; // Forward from WB stage (same logic for FPU and ALU)
    end else begin
      ForwardB = 2'b00; // No forwarding
    end

    // Default ForwardA
    if (regWriteMem && (rdMem !== 5'b0) && (rdMem === rs1)) begin
      ForwardA = FPUEnable ? 2'b11 : 2'b10; // Forward FPU result (2'b11) or ALU result (2'b10)
    end else if (regWriteWb && (rdWb !== 5'b0) && (rdWb === rs1)) begin
      ForwardA = FPUEnable ? 2'b01 : 2'b01; // Forward from WB stage (same logic for FPU and ALU)
    end else begin
      ForwardA = 2'b00; // No forwarding
    end
  end

endmodule
