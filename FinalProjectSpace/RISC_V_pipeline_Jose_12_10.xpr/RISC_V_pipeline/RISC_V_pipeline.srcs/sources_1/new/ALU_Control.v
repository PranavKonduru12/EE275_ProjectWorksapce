`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2024 11:00:59 PM
// Design Name: 
// Module Name: ALU_Control
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
module ALU_Control(
  input wire [1:0] ALUOp,           // ALU operation selector
  input wire [3:0] Funct,           // Function field for R-type or FPU operations
  output reg [3:0] Operation        // ALU operation code
);

  always @(ALUOp or Funct) begin
    case (ALUOp)
      2'b00: begin
        Operation <= 4'b0010; // Load/Store: Perform ADD
      end
      2'b01: begin
        Operation <= 4'b0110; // Branch: Perform SUB
      end
      2'b10: begin
        // R-type integer operations
        case (Funct)
          4'b0000: Operation <= 4'b0010; // ADD
          4'b1000: Operation <= 4'b0110; // SUB
          4'b0111: Operation <= 4'b0000; // AND
          4'b0110: Operation <= 4'b0001; // OR
          default: Operation <= 4'b1111; // Undefined operation
        endcase
      end
      2'b11: begin
        // Floating-point operations (FPU)
        case (Funct)
          4'b0000: Operation <= 4'b1000; // FADD
          4'b0001: Operation <= 4'b1001; // FSUB
          default: Operation <= 4'b1111; // Undefined FPU operation
        endcase
      end
      default: begin
        Operation <= 4'b1111; // Undefined operation
      end
    endcase
  end
endmodule

