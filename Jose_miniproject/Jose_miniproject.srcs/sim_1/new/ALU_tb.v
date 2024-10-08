`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2024 12:12:18 PM
// Design Name: 
// Module Name: ALU_tb
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
        
         //Test ADD operation: ADD R2, R3, R4 (R2 = R3 + R4)
//        instruction = 32'b000000_00010_00011_00100_00000000000; // ADD R2, R3, R4
//        #10;

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

//        // Test JMP (Unconditional Jump)
//        instruction = 32'b001001_00000_00010_00000_00000000000; // JMP to R2
//        #10;
          
//          //Test Load operation
          instruction = 32'b000111_00001_00000_00000_00000000010; // JMP to R2
          #10;

         //End of test
        $finish;
    end

endmodule



///////ALU Test Bench
//module ALU_tb;

//    // Inputs
//    reg [31:0] a, b;
//    reg [3:0] operation;
//    reg cin;

//    // Outputs
//    wire [31:0] result;
//    wire overflow, underflow;
//    wire equal, less_than, less_than_equal;
//    wire carry_out;

//    // Instantiate the ALU
//    ALU uut (
//        .a(a),
//        .b(b),
//        .operation(operation),
//        .cin(cin),
//        .result(result),
//        .overflow(overflow),
//        .underflow(underflow),
//        .equal(equal),
//        .less_than(less_than),
//        .less_than_equal(less_than_equal),
//        .carry_out(carry_out)
//    );

//    // Testbench
//    initial begin
//        $monitor("Time: %0d, a: %0d, b: %0d, operation: %b, result: %0d, overflow: %b, underflow: %b, equal: %b, less_than: %b, less_than_equal: %b", $time, a, b, operation, result, overflow, underflow, equal, less_than, less_than_equal);

//        // Initialize inputs
//        a = 0;
//        b = 0;
//        cin = 0;
//        operation = 4'b0000;

//        // Test addition
//        #10 a = 32'd100; b = 32'd50; operation = 4'b0000; // Add a + b
//        #10 a = 32'd2147483647; b = 32'd1; operation = 4'b0000; // Test for overflow

//        // Test subtraction
//        #10 a = 32'd100; b = 32'd50; operation = 4'b0001; // Subtract a - b
//        #10 a = 32'd0; b = 32'd1; operation = 4'b0001; // Test for underflow

//        // Test multiplication
//        #10 a = 32'd2000000000; b = 32'd2000000000; operation = 4'b0010; // Multiply a * b
//        //#10 a = 32'd9; b = 32'd3; operation = 4'b0010; // Multiply a * b
        
//        // Test AND operation
//        #10 a = 32'hFFFF0000; b = 32'h0000FFFF; operation = 4'b0011; // AND

//        // Test OR operation
//        #10 a = 32'hFFFF0000; b = 32'h0000FFFF; operation = 4'b0100; // OR

//        // Test XOR operation
//        #10 a = 32'hAAAA5555; b = 32'h5555AAAA; operation = 4'b0101; // XOR

//        // Test NOT operation
//        #10 a = 32'hAAAAAAAA; operation = 4'b0110; // NOT

//        // Test EqualTo comparator
//        #10 a = 32'h0000000F; b = 32'h0000000F; operation = 4'b0111; // EqualTo

//        // Test LessThan comparator
//        #10 a = 32'h00000001; b = 32'h0000000F; operation = 4'b1000; // LessThan

//        // Test LessThanEqualTo comparator
//        #10 a = 32'h0000000F; b = 32'h0000000F; operation = 4'b1001; // LessThanEqualTo

//        #10 $finish;
//    end

//endmodule

