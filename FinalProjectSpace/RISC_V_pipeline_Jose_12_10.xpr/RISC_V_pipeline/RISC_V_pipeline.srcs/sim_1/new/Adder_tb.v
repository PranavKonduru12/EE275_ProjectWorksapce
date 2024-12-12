`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2024 09:23:42 PM
// Design Name: 
// Module Name: Adder_tb
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


module Adder_tb();
    reg [63:0] a;       
    reg [63:0] b;       
    reg [31:0] floatA;  
    reg [31:0] floatB;  
    reg isFloat;        
    wire [63:0] out;    
    wire [31:0] floatOut;


    Adder uut (                
        .a(a),       
        .b(b),       
        .floatA(floatA),  
        .floatB(floatB),  
        .isFloat(isFloat),        
        .out(out),    
        .floatOut(floatOut)
    );
    initial begin
        $display("Starting ALU_FPU Testbench...");

        // Test integer operations
        a = 64'hFFFFFFFFFFFFFFFE; b = 64'h0000000000000005; isFloat = 0; #10;
        $display("ADD: - 2 + 5 Result=%h, Expected=0000000000000003", out);
        
        a = 64'h000000000000000A; b = 64'h0000000000000005; isFloat = 0; #10;
        $display("SUB: 10 - 4 Result=%h, Expected=0000000000000005", out);

        // Test floating-point operations
        ///ADD
        floatA = {32'b0, 32'h40400000}; floatB = {32'b0, 32'h40830000}; isFloat = 1; #10;
        $display("FADD 3.0 +  4.09375: Result=%h, Expected=40e30000", floatOut[31:0]);
        
        floatA = {32'b0, 32'h4125FE84}; floatB = {32'b0, 32'h42F0BFAA}; isFloat = 1; #10;    
        $display("FADD 10.374637603759765625 + 120.3743438720703125 : Result=%h, Expected=4302BFBD", floatOut[31:0]);
        
        ///SUB
        floatA = {32'b0, 32'h40400000}; floatB = {32'b0, 32'h40000000}; isFloat = 1; #10;
        $display("FSUB 3.0 - 2.0: Result=%h, Expected=3f800000", floatOut[31:0]);
        
        floatA = {32'b0, 32'h40421000}; floatB = {32'b0, 32'h40033000}; isFloat = 1; #10;
        $display("FSUB 3.0322265625 - 2.0498046875: Result=%h, Expected=3f7b8000", floatOut[31:0]);
        $finish;
    end
endmodule  
