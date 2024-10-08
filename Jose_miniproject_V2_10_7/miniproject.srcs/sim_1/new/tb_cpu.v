`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2024 01:06:47 PM
// Design Name: 
// Module Name: tb_cpu
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


module CPU_tb;

    // Inputs
    reg clk;
    reg [31:0] instruction;   // 32-bit instruction input to CPU

    // Outputs
    wire [31:0] result;       // Result from CPU operation

    // Instantiate the CPU
    CPU uut (
        .clk(clk),
        .instruction(instruction),
        .result(result)
    );

    // Clock generation
    always #5 clk = ~clk;  // Generate clock with a period of 10 time units

    // Testbench
    initial begin
        $monitor("Time: %0d, Instruction: %h, Result: %0d", $time, instruction, result);

        // Initialize clock
        clk = 0;

        // OpCode: bits 31-26            
        // Destination register: bits 25-21
        // Source register 1: bits 20-16
        // Source register 2: bits 15-11
        // Immediate/Address: bits 10-0
        
        // Test ADD operation: ADD R2, R3, R4 (R2 = R3 + R4)
        instruction = 32'b000000_00010_00011_00100_00000000000; // ADD R2, R3, R4
        #10;

//        // Test SUB operation: SUB R2, R3, R4 (R2 = R3 - R4)
//        instruction = 32'b000001_00010_00011_00100_00000000000; // SUB R2, R3, R4
//        #10;

//        // Test MULT operation: MULT R2, R3, R4 (R2 = R3 * R4)
//        instruction = 32'b000010_00010_00011_00100_00000000000; // MULT R2, R3, R4
//        #10;

//        // Test AND operation: AND R2, R3, R4 (R2 = R3 & R4)
//        instruction = 32'b000011_00010_00011_00100_00000000000; // AND R2, R3, R4
//        #10;

//        // Test OR operation: OR R2, R3, R4 (R2 = R3 | R4)
//        instruction = 32'b000100_00010_00011_00100_00000000000; // OR R2, R3, R4
//        #10;

//        // Test XOR operation: XOR R2, R3, R4 (R2 = R3 ^ R4)
//        instruction = 32'b000101_00010_00011_00100_00000000000; // XOR R2, R3, R4
//        #10;

//        // Test NOT operation: NOT R2, R3 (R2 = ~R3)
//        instruction = 32'b000110_00010_00011_00000_00000000000; // NOT R2, R3
//        #10;

//        // Test Immediate Mode LOAD operation
//        // LOAD from memory address 10 into R2
//        instruction = 32'b000111_00010_00000_00000_00000001010; // LOAD R2, [10]
//        #10;

//        // Test Immediate Mode STORE operation
//        // STORE R3 into memory address 10
//        instruction = 32'b001000_00000_00011_00000_00000001010; // STORE R3, [10]
//        #10;

//        // Test JMP (Unconditional Jump)
//        instruction = 32'b001001_00000_00010_00000_00000000000; // JMP to R2
//        #10;

//        // Test Conditional Jump (JLT) based on LessThan flag
//        instruction = 32'b001010_00000_00010_00000_00000000000; // JLT to R2 if LessThan flag set
//        #10;

//        // Test Procedure Call (CALL)
//        instruction = 32'b001011_00000_00010_00000_00000000000; // CALL procedure at address R2
//        #10;

//        // Test Return from Procedure (RET)
//        instruction = 32'b001100_00000_00000_00000_00000000000; // RET (Return from procedure)
//        #10;

        // End of test
        $finish;
    end

endmodule
