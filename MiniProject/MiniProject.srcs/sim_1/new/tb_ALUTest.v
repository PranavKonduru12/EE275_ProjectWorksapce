`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/02/2024 02:34:24 AM
// Design Name: 
// Module Name: tb_ALUTest
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


module ALU_tb;

    // Inputs
    reg [31:0] a, b;
    reg [3:0] operation;
    reg cin;

    // Outputs
    wire [31:0] result;
    wire overflow, underflow;
    wire equal, less_than, less_than_equal;
    wire carry_out;

    // Instantiate the ALU
    ALU uut (
        .a(a),
        .b(b),
        .operation(operation),
        .cin(cin),
        .result(result),
        .overflow(overflow),
        .underflow(underflow),
        .equal(equal),
        .less_than(less_than),
        .less_than_equal(less_than_equal),
        .carry_out(carry_out)
    );

    // Testbench
    initial begin
        $monitor("Time: %0d, a: %0d, b: %0d, operation: %b, result: %0d, overflow: %b, underflow: %b, equal: %b, less_than: %b, less_than_equal: %b", $time, a, b, operation, result, overflow, underflow, equal, less_than, less_than_equal);

        // Initialize inputs
        a = 0;
        b = 0;
        cin = 0;
        operation = 4'b0000;

        // Test addition
        #10 a = 32'd100; b = 32'd50; operation = 4'b0000; // Add a + b
        #10 a = 32'd2147483647; b = 32'd1; operation = 4'b0000; // Test for overflow

        // Test subtraction
        #10 a = 32'd100; b = 32'd50; operation = 4'b0001; // Subtract a - b
        #10 a = 32'd0; b = 32'd1; operation = 4'b0001; // Test for underflow

        // Test multiplication
        #10 a = 32'd5; b = 32'd3; operation = 4'b0010; // Multiply a * b
        #10 a = 32'd0; b = 32'd0; operation = 4'b0010; // Multiply a * b
        #10 a = -32'd6; b = 32'd3; operation = 4'b0010; // Multiply a * b
        #10 a = 32'd10; b = 32'd3; operation = 4'b0010; // Multiply a * b

        // Test AND operation
        #10 a = 32'hFFFF0000; b = 32'h0000FFFF; operation = 4'b0011; // AND
// Test OR operation
        #10 a = 32'hFFFF0000; b = 32'h0000FFFF; operation = 4'b0100; // OR

        // Test XOR operation
        #10 a = 32'hAAAA5555; b = 32'h5555AAAA; operation = 4'b0101; // XOR

        // Test NOT operation
        #10 a = 32'hAAAAAAAA; operation = 4'b0110; // NOT

        // Test EqualTo comparator
        #10 a = 32'h0000000F; b = 32'h0000000F; operation = 4'b0111; // EqualTo

        // Test LessThan comparator
        #10 a = 32'h00000001; b = 32'h0000000F; operation = 4'b1000; // LessThan

        // Test LessThanEqualTo comparator
        #10 a = 32'h0000000F; b = 32'h0000000F; operation = 4'b1001; // LessThanEqualTo

        #10 $finish;
    end

endmodule
