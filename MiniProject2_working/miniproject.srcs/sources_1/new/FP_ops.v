`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2024 03:55:42 PM
// Design Name: 
// Module Name: FP_ops
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


module FP_ops(
    input           clk,
    input   [31:0]  instruction,
    output  [31:0]  result   
    );
    
//    wire [31:0] reg_data1, reg_data2;            // Register values read from the Register File
//    wire [31:0] alu_result;                      // ALU result
//    reg [31:0] memory_data;                      // To handle memory-related operations
//    reg reg_write;                              // Enable register write
//    reg [31:0] memory [0:255];                  // Simple memory (256 words)
    
    wire [4:0] cc_flags;                        // Condition Code flags from ALU (overflow, underflow, etc.)
    wire [5:0] opcode = instruction[31:26];     // OpCode: bits 31-26
    wire [4:0] rd = instruction[25:21];         // Destination register: bits 25-21
    wire [4:0] rs1 = instruction[20:16];        // Source register 1: bits 20-16
    wire [4:0] rs2 = instruction[15:11];        // Source register 2: bits 15-11
    wire [10:0] immediate = instruction[10:0];  // Immediate/Address: bits 10-0
    
    // Instantiate Register File
    RegisterFile regfile (
        .clk(clk),
        .read_reg1(rs1), 
        .read_reg2(rs2), 
        .write_reg(rd), 
        .write_data(alu_result), 
        .reg_write(reg_write), 
        .reg_data1(reg_data1), 
        .reg_data2(reg_data2),
        .cc_flags(cc_flags),                     // Pass CC flags to Register File
        .pc(),                   // Program Counter (R0)
        .sp()
    );
    
    // Instantiate ALU
    FP_ALU fp_alu (
        .a(reg_data1),
        .b(reg_data2),
        .operation(opcode[3:0]),     // The lower 4 bits of the opcode are passed to the ALU for operation
        .cin(1'b0),                  // Carry-in is 0 for now
        .result(alu_result),
        .overflow(cc_flags[4]),      // Overflow flag
        .underflow(cc_flags[3]),     // Underflow flag
//        .equal(cc_flags[2]),         // Equal flag
//        .less_than(cc_flags[1]),     // Less than flag
//        .less_than_equal(cc_flags[0]), // Less than or equal flag
        .carry_out()                 // Not used for now
    );
endmodule
