`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2024 07:48:32 PM
// Design Name: 
// Module Name: FPU_tb
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


module FPU_tb();
    reg [31:0] opA;    
    reg [31:0] opB;    
    reg FADD_FSUB;     
    wire [31:0] result; 
    wire [1:0] exception;
    
    FPU uut (                   
    opA,    
    opB,    
    FADD_FSUB,     
    result, 
    exception
    );
    
    initial begin
        $display("Starting ALU_FPU Testbench...");

//        // Test integer operations
//        a = 64'hFFFFFFFFFFFFFFFE; b = 64'h0000000000000005; isFloat = 0; #10;
//        $display("ADD: -2 + 5 Result=%h, Expected=0000000000000003", out);
        
//        a = 64'h000000000000000A; b = 64'h0000000000000005; isFloat = 0; #10;
//        $display("SUB: 10 - 4 Result=%h, Expected=0000000000000005", out);

        // Test floating-point operations
        ///ADD
        opA = {32'b0, 32'h40400000}; opB = {32'b0, 32'h40830000}; FADD_FSUB = 0; #10;
        $display("FADD 3.0 +  4.09375: Result=%h, Expected=40e30000", result[31:0]);
        
        opA = {32'b0, 32'h4125FE84}; opB = {32'b0, 32'h42F0BFAA}; FADD_FSUB = 0; #10;    
        $display("FADD 10.374637603759765625 + 120.3743438720703125 : Result=%h, Expected=4302BFBD", result[31:0]);
        
        ///SUB
        opA = {32'b0, 32'h40400000}; opB = {32'b0, 32'h40000000}; FADD_FSUB = 1; #10;
        $display("FSUB 3.0 - 2.0: Result=%h, Expected=3f800000", result[31:0]);
        
        opA = {32'b0, 32'h40421000}; opB = {32'b0, 32'h40033000}; FADD_FSUB = 1; #10;
        $display("FSUB 3.0322265625 - 2.0498046875: Result=%h, Expected=3f7b8000", result[31:0]);
        
        //EXCEPTION Zero
        opA = {32'b0, 32'h80000000}; opB = {32'b0, 32'h00000000}; FADD_FSUB = 1; #10;
        $display("FSUB - 0 + 0: Result=%h, Expected=80000000", result[31:0]);
        
        //EXCEPTION Infinity
        opA = {32'b0, 32'h7F800000}; opB = {32'b0, 32'hFF800000}; FADD_FSUB = 0; #10;
        $display("FADD - infi + infi: Result=%h, Expected=7FFFFFFF", result[31:0]);
        $finish;
    end                            
endmodule
