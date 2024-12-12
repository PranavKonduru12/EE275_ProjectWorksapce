`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2024 11:58:18 PM
// Design Name: 
// Module Name: tb
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

module TestBench;
    reg clk;
    reg reset;
    wire [63:0] PC_Out;
    wire [31:0] Instruction;
    wire [63:0] ALUResult;
    wire [31:0] FPUResult;
    wire [1:0] FPUException;

    // Instantiate the top-level module (RISC_V_Processor)
    RISC_V_Processor uut (
        .clk(clk),
        .reset(reset),
        .PC_Out(PC_Out),
        .Instruction(Instruction),
        .ALUResult(ALUResult),
        .FPUResult(FPUResult),
        .FPUException(FPUException)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        #10 reset = 0;

        // Wait for some time and then finish
        #1000 $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time=%t | PC=%h | Instruction=%h | ALUResult=%h | FPUResult=%h | FPUException=%b", 
                  $time, PC_Out, Instruction, ALUResult, FPUResult, FPUException);
    end
endmodule
//module tb();

//  reg clk, reset;

//  RISC_V_Processor uut(.clk(clk), .reset(reset));
//  initial
//  begin
//    clk = 0;
//    reset = 1;
//    #5 reset = 0;
//  end
  
//  always
//    #5 clk = ~clk;
    
//endmodule
