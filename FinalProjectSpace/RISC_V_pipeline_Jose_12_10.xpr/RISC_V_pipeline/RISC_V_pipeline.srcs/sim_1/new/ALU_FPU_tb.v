`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2024 03:46:55 PM
// Design Name: 
// Module Name: ALU_FPU_tb
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

module ALU_FPU_tb;

    reg [63:0] a, b;
    reg [3:0] ALUOp;
    wire [63:0] Result;
    wire zero;

    ALU_64_bit uut (
        .a(a),
        .b(b),
        .ALUOp(ALUOp),
        .Result(Result),
        .zero(zero)
    );

    initial begin
        $display("Starting ALU_FPU Testbench...");

        // Test integer operations
        a = 64'h000000000000000A; b = 64'h0000000000000005; ALUOp = 4'b0010; #10;
        $display("ADD: Result=%h, Expected=000000000000000F", Result);
        
        a = 64'h000000000000000A; b = 64'h0000000000000005; ALUOp = 4'b0110; #10;
        $display("SUB: Result=%h, Expected=0000000000000005", Result);

        // Test floating-point operations
        ///ADD
        a = {32'b0, 32'h40400000}; b = {32'b0, 32'h40830000}; ALUOp = 4'b1000; #10;
        $display("FADD 3.0 +  4.09375: Result=%h, Expected=40e30000", Result[31:0]);
        
        a = {32'b0, 32'h4125FE84}; b = {32'b0, 32'h42F0BFAA}; ALUOp = 4'b1000; #10;    
        $display("FADD 10.374637603759765625 + 120.3743438720703125 : Result=%h, Expected=4302BFBD", Result[31:0]);
        
        ///SUB
        a = {32'b0, 32'h40400000}; b = {32'b0, 32'h40000000}; ALUOp = 4'b1001; #10;
        $display("FSUB 3.0 - 2.0: Result=%h, Expected=3f800000", Result[31:0]);
        
        a = {32'b0, 32'h40421000}; b = {32'b0, 32'h40033000}; ALUOp = 4'b1001; #10;
        $display("FSUB 3.0322265625 - 2.0498046875: Result=%h, Expected=3f7b8000", Result[31:0]);
        $finish;
    end
endmodule
