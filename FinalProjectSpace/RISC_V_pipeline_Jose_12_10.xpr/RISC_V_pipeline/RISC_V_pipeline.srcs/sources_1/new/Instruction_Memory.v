`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2024 11:44:59 PM
// Design Name: 
// Module Name: Instruction_Memory
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
module Instruction_Memory(
  input wire [63:0] Inst_Address,
  output reg [31:0] Instruction 
);
  reg [7:0] insMem [15:0];
   initial begin
    // Example instruction set for testing
    insMem[15] = 8'hB3;  // ADD
    insMem[14] = 8'h85;  // ADD
    insMem[13] = 8'h34;  // ADD
    insMem[12] = 8'h83;  // ADD
    insMem[11] = 8'h00;  // FADD
    insMem[10] = 8'h14;  // FADD
    insMem[9] = 8'h84;   // FADD
    insMem[8] = 8'h93;   // FADD
    insMem[7] = 8'h0;    // FSUB
    insMem[6] = 8'h9A;   // FSUB
    insMem[5] = 8'h84;   // FSUB
    insMem[4] = 8'hB3;   // FSUB
    insMem[3] = 8'h02;   // Branch
    insMem[2] = 8'h85;   // Branch
    insMem[1] = 8'h34;   // Branch
    insMem[0] = 8'h23;   // Branch
  end
//  initial
//  begin
//    insMem[15] = 8'h02;
//    insMem[14] = 8'h95;
//    insMem[13] = 8'h34;
//    insMem[12] = 8'h23;
//    insMem[11] = 8'h00;
//    insMem[10] = 8'h14;
//    insMem[9] = 8'h84;
//    insMem[8] = 8'h93;
//    insMem[7] = 8'h0;
//    insMem[6] = 8'h9A;
//    insMem[5] = 8'h84;
//    insMem[4] = 8'hB3;
//    insMem[3] = 8'h02;
//    insMem[2] = 8'h85;
//    insMem[1] = 8'h34;
//    insMem[0] = 8'h83;
//  end
  always @(Inst_Address)
  begin
    Instruction <= {insMem[Inst_Address[3:0]+3], 
    insMem[Inst_Address[3:0]+2], 
    insMem[Inst_Address[3:0]+1], 
    insMem[Inst_Address[3:0]+0]};
  end
endmodule 


//Update if need to read from external file 
//module Instruction_Memory(
//  input wire [63:0] Inst_Address,  // Instruction address
//  output reg [31:0] Instruction    // Fetched instruction
//);

//  reg [7:0] insMem [0:255];        // Expanded instruction memory (256 bytes)
  
//  initial begin
//    // Pre-load example instructions (can be extended or replaced dynamically)
//    insMem[15] = 8'h02;
//    insMem[14] = 8'h95;
//    insMem[13] = 8'h34;
//    insMem[12] = 8'h23;
//    insMem[11] = 8'h00;
//    insMem[10] = 8'h14;
//    insMem[9] = 8'h84;
//    insMem[8] = 8'h93;
//    insMem[7] = 8'h00;
//    insMem[6] = 8'h9A;
//    insMem[5] = 8'h84;
//    insMem[4] = 8'hB3;
//    insMem[3] = 8'h02;
//    insMem[2] = 8'h85;
//    insMem[1] = 8'h34;
//    insMem[0] = 8'h83;
//  end

//  always @(Inst_Address) begin
//    Instruction <= {insMem[Inst_Address[3:0] + 3],
//                    insMem[Inst_Address[3:0] + 2],
//                    insMem[Inst_Address[3:0] + 1],
//                    insMem[Inst_Address[3:0] + 0]};
//    // Debugging statement
//    $display("Instruction_Memory: Fetched instruction %h from address %h", Instruction, Inst_Address);
//  end

//endmodule
