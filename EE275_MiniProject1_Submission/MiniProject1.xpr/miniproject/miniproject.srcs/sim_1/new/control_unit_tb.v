`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2024 10:47:44 PM
// Design Name: 
// Module Name: control_unit_tb
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


module tb_control_unit;
    // Inputs
    reg clk;
    reg reset;
    reg [31:0] instruction;

    // Outputs
    wire [3:0] operation;
    wire [3:0] src1;
    wire [3:0] src2;
    wire [3:0] dest;
    wire reg_write;
    wire [31:0] immediate;
    wire use_immediate;

    // Instantiate the control unit
    control_unit uut (
        .clk(clk),
        .reset(reset),
        .instruction(instruction),
        .operation(operation),
        .src1(src1),
        .src2(src2),
        .dest(dest),
        .reg_write(reg_write),
        .immediate(immediate),
        .use_immediate(use_immediate)
    );

    // Clock generation
    always #5 clk = ~clk;  // Toggle clock every 5 time units

    initial begin
        // Initialize inputs
        clk = 0;
        reset = 0;
        instruction = 32'b0;

        // Reset the control unit
        $display("Applying reset...");
        reset = 1;
        #10;   // Wait for a clock cycle
        reset = 0;
        #10;

        // Test 1: Regular operation (non-immediate)
        $display("Testing a regular operation (opcode 4'b0001)...");
        instruction = 32'b0001_0001_0010_0011_0000000000000000; // opcode = 4'b0001, src1=4'b0001, src2=4'b0010, dest=4'b0011
        #10;
        $display("Operation: %b, Src1: %b, Src2: %b, Dest: %b, Reg Write: %b", operation, src1, src2, dest, reg_write);
        
        // Test 2: Immediate operation
        $display("Testing an immediate operation (opcode 4'b0100)...");
        instruction = 32'b0100_0010_0011_0100_0000000000001010; // opcode = 4'b0100, src1=4'b0010, dest=4'b0100, immediate=16'b1010
        #10;
        $display("Operation: %b, Src1: %b, Src2: %b, Dest: %b, Immediate: %d, Use Immediate: %b", operation, src1, src2, dest, immediate, use_immediate);

        // Test 3: Another regular operation
        $display("Testing another regular operation (opcode 4'b0010)...");
        instruction = 32'b0010_0101_0110_0111_0000000000000000; // opcode = 4'b0010, src1=4'b0101, src2=4'b0110, dest=4'b0111
        #10;
        $display("Operation: %b, Src1: %b, Src2: %b, Dest: %b, Reg Write: %b", operation, src1, src2, dest, reg_write);

        // Test 4: Immediate operation with reset applied during instruction execution
        $display("Testing immediate operation with reset...");
        instruction = 32'b0100_1000_1001_1010_0000000000001111; // opcode = 4'b0100, src1=4'b1000, dest=4'b1010, immediate=16'b1111
        #5;
        reset = 1;  // Apply reset in the middle of execution
        #10;
        reset = 0;
        #10;
        $display("After reset - Operation: %b, Src1: %b, Src2: %b, Dest: %b, Immediate: %d, Use Immediate: %b", operation, src1, src2, dest, immediate, use_immediate);

        $finish;  
    end
endmodule

