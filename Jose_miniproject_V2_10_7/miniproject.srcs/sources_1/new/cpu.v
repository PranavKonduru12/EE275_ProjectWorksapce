`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/07/2024 10:07:32 PM
// Design Name: 
// Module Name: cpu
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


//////////////////////////////////////////////////////////////////////////////CPU

module CPU (
    input clk,                                 // Clock signal
    input [31:0] instruction,                  // Input instruction (for simplicity, loaded directly)
    output [31:0] result                       // Result of the operation
);
   
    wire [31:0] reg_data1, reg_data2;            // Register values read from the Register File
    wire [31:0] alu_result;                      // ALU result
    reg [31:0] memory_data;                      // To handle memory-related operations
    reg reg_write;                              // Enable register write
    reg [31:0] memory [0:255];                  // Simple memory (256 words)
    
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
        .cc_flags(cc_flags)                     // Pass CC flags to Register File
    );
    
    // Instantiate ALU
    ALU alu (
        .a(reg_data1),
        .b(reg_data2),
        .operation(opcode[3:0]),     // The lower 4 bits of the opcode are passed to the ALU for operation
        .cin(1'b0),                  // Carry-in is 0 for now
        .result(alu_result),
        .overflow(cc_flags[4]),      // Overflow flag
        .underflow(cc_flags[3]),     // Underflow flag
        .equal(cc_flags[2]),         // Equal flag
        .less_than(cc_flags[1]),     // Less than flag
        .less_than_equal(cc_flags[0]), // Less than or equal flag
        .carry_out()                 // Not used for now
    );
    
    // Decode and Execute logic
    always @(posedge clk) begin
        case (opcode)
            6'b000000: begin // ADD
                // ALU will perform addition, result will be in alu_result
                reg_write <= 1;  // Enable register write
            end
            6'b000001: begin // SUB
                // ALU will perform subtraction
                reg_write <= 1;  // Enable register write
            end
            6'b000010: begin // MULT
                // ALU will perform multiplication
                reg_write <= 1;  // Enable register write
            end
            6'b000011: begin // AND
                // ALU will perform bitwise AND
                reg_write <= 1;
           end
           6'b000100: begin // OR
                // ALU will perform bitwise OR
                reg_write <= 1;
           end
           6'b000101: begin // XOR
                reg_write <= 1;
           end
           6'b000110: begin // NOT
                reg_write <= 1;
           end            
           6'b000111: begin // LOAD (Immediate Mode)
            // Memory read operation using immediate value
            memory_data <= memory[immediate];  // Load from memory address in 'immediate'
            reg_write <= 1;
            end
            6'b001000: begin // STORE (Immediate Mode)
            // Memory write operation using immediate value
            memory[immediate] <= reg_data1;  // Store reg_data1 into memory
            reg_write <= 0;
            end
            6'b001001: begin // JMP (Unconditional Jump)
                 // Jump to address in reg_data1 (Rs1)
                 // Not implemented in this simple design
            end
            6'b001010: begin // Conditional Jump (JLT)
                 if (cc_flags[1]) begin  // If LessThan flag is set
                     // Jump to address in reg_data1 (Rs1)
                     // Not implemented in this simple design
                 end
            end
            6'b001011: begin // CALL Procedure
                  // Decrement Stack Pointer
                  // Save PC and call procedure at address in reg_data1 (Rs1)
                  // Not implemented in this simple design
            end
            6'b001100: begin // RET (Return from Procedure)
                  // Restore PC from stack
                  // Not implemented in this simple design
            end
            
            default: begin
                reg_write <= 0;  // Do nothing for unrecognized OpCode
            end
        endcase
    end
    
    // Output the final result, either from the ALU or memory read
    assign result = (opcode == 6'b000111) ? memory_data : alu_result;

endmodule
