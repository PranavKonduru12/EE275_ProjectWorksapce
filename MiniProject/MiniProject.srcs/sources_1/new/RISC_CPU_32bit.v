`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2024 04:22:07 PM
// Design Name: 
// Module Name: RISC_CPU_32bit
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

module CPU(
    input clk,                // Clock signal
    input reset,              // Reset signal
    input [31:0] instruction, // Input instruction (32-bit)
    input [31:0] memory_data_in, // Data from memory (for load instructions)
    output reg [31:0] memory_address, // Memory address for load/store
    output reg [31:0] memory_data_out, // Data to be stored in memory
    output reg mem_write,         // Memory write flag
    output reg mem_read,          // Memory read flag
    output [31:0] pc          // Program counter
);

    // Internal signals
    reg [31:0] PC; // Program Counter (R0)
    wire [31:0] ALU_result;
    wire [3:0] opcode;
    wire [3:0] rs1, rs2, rd;
    wire [31:0] read_data1, read_data2;
    reg  [31:0] write_data;
    wire [31:0] immediate;
    reg write_enable;
    reg [3:0] alu_op;
    wire [31:0] result;
    wire carry_out, overflow, underflow, mult_overflow;
    wire equal, less_than, less_than_equal;
    
    

    // Initialize Program Counter
    initial begin
        PC = 32'b0; // Set PC to zero on reset
    end

    // Fetch the current instruction from the input
    assign opcode = instruction[31:28]; // Top 4 bits for opcode
    assign rd = instruction[27:24];     // Destination register
    assign rs1 = instruction[23:20];    // Source register 1
    assign rs2 = instruction[19:16];    // Source register 2
    assign immediate = instruction[15:0]; // Immediate value

    // Register file instantiation
    regfile register_file(
        .clk(clk),
        .readReg1(rs1),
        .readReg2(rs2),
        .writeReg(rd),
        .writeData(write_data),
        .write(write_enable),
        .readData1(read_data1),
        .readData2(read_data2)
    );

    // ALU instantiation
    ALU alu (
        .a(read_data1),
        .b((opcode == 4'b0010) ? immediate : read_data2), // Use immediate value for immediate instructions
        .operation(alu_op),
        .cin(1'b0),
        .result(result),
        .overflow(overflow),
        .underflow(underflow),
        .mult_overflow(mult_overflow),
        .equal(equal),
        .less_than(less_than),
        .less_than_equal(less_than_equal),
        .carry_out(carry_out)
    );

    // Control Unit (Simple decoder for opcode)
    always @(*) begin
        // Reset memory control signals
        mem_write = 0;
        mem_read = 0;
        case (opcode)
            4'b0000: begin // ADD
                alu_op = 4'b0000;
                write_enable = 1;
                write_data = result;
                //write_reg = rd; 
            end
//            4'b0001: begin // SUB
//                alu_op = 4'b0001;
//                write_enable = 1;
//            end
//            4'b0010: begin // LOAD IMMEDIATE
//                alu_op = 4'b0000; // Use ALU as a passthrough for immediate value
//                write_enable = 1;
//            end
//            4'b0011: begin // STORE to Memory
//                alu_op = 4'b0000; // Perform ALU operation (sum of address)
//                mem_write = 1;
//                mem_read = 0;
//                memory_data_out = read_data2; // Store data in memory
//                memory_address = result;      // Memory address from ALU result
//                write_enable = 0;
//            end
//            4'b0100: begin // LOAD from Memory
//                alu_op = 4'b0000; // Perform ALU operation (sum of address)
//                mem_write = 0;
//                mem_read = 1;
//                memory_address = result;
//                write_enable = 1;
//                write_data = memory_data_in; // Write the loaded memory value to register
//            end
//            default: begin
//                alu_op = 4'b0000;
//                write_enable = 0;
//                mem_write = 0;
//                mem_read = 0;
//            end
        endcase
    end

    // Program Counter Update Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            PC <= 32'b0;
        end else begin
            PC <= PC + 4; // Increment PC by 4 for the next instruction
        end
    end

    // Output the current PC value
    assign pc = PC;

endmodule

//module RISC_CPU_32bit(
//    input clk,
//    input[31:0] instr,
//    output[63:0] result
//    );
    
//    ALU cpu_ALU(                    
//    a, b,        
//    operation,    
//    cin,        
//    result,      
//    overflow, underflow, mult_overflow, 
//    equal, less_than, less_than_equal, 
//    carry_out           
//    );
    
//     regfile CPU_reg(
//     clk,
//     readReg1,   
//     readReg2,   
//     writeReg,   
//     writeData,
//     write,      
//     readData1,
//     readData2 
//      );  
//endmodule
