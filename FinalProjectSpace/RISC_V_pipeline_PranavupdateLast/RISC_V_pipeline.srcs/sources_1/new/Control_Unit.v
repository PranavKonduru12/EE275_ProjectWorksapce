`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2024 10:48:06 PM
// Design Name: 
// Module Name: Control_Unit
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

module Control_Unit(
  input wire [6:0] Opcode,
  output reg Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, 
  output reg [1:0] ALUOp,
  output reg FPUEnable // New signal to enable FPU operations
);

  always @(Opcode) begin
    if (Opcode == 7'b0110011) begin // R-type integer instructions
      ALUSrc <= 0;
      MemtoReg <= 0;
      RegWrite <= 1;
      MemRead <= 0;
      MemWrite <= 0;
      Branch <= 0;
      ALUOp <= 2'b10;
      FPUEnable <= 0; // Disable FPU
    end else if (Opcode == 7'b0000011) begin // Load
      ALUSrc <= 1;
      MemtoReg <= 1;
      RegWrite <= 1;
      MemRead <= 1;
      MemWrite <= 0;
      Branch <= 0;
      ALUOp <= 2'b00;
      FPUEnable <= 0; // Disable FPU
    end else if (Opcode == 7'b0100011) begin // Store
      ALUSrc <= 1;
      MemtoReg <= 1;
      RegWrite <= 0;
      MemRead <= 0;
      MemWrite <= 1;
      Branch <= 0;
      ALUOp <= 2'b00;
      FPUEnable <= 0; // Disable FPU
    end else if (Opcode == 7'b1100011) begin // Branch
      ALUSrc <= 0;
      MemtoReg <= 0;
      RegWrite <= 0;
      MemRead <= 0;
      MemWrite <= 0;
      Branch <= 1;
      ALUOp <= 2'b01;
      FPUEnable <= 0; // Disable FPU
    end else if (Opcode == 7'b1010000) begin // FADD (Floating-Point Addition)
      ALUSrc <= 0;
      MemtoReg <= 0;
      RegWrite <= 1;
      MemRead <= 0;
      MemWrite <= 0;
      Branch <= 0;
      ALUOp <= 2'b11; // New ALUOp for FPU operations
      FPUEnable <= 1; // Enable FPU
    end else if (Opcode == 7'b1010001) begin // FSUB (Floating-Point Subtraction)
      ALUSrc <= 0;
      MemtoReg <= 0;
      RegWrite <= 1;
      MemRead <= 0;
      MemWrite <= 0;
      Branch <= 0;
      ALUOp <= 2'b11; // New ALUOp for FPU operations
      FPUEnable <= 1; // Enable FPU
    end else begin // Default case
      ALUSrc <= 0;
      MemtoReg <= 0;
      RegWrite <= 0;
      MemRead <= 0;
      MemWrite <= 0;
      Branch <= 0;
      ALUOp <= 2'b00;
      FPUEnable <= 0; // Disable FPU
    end
  end
endmodule

