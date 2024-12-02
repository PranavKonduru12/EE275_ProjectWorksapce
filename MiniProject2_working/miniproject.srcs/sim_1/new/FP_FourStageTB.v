`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2024 07:14:12 PM
// Design Name: 
// Module Name: FP_FourStageTB
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


module fpu_4stage_tb;
    // Inputs
    reg clk;
    reg rst;
    reg [31:0] opA;
    reg [31:0] opB;
    reg opSelect;

    // Outputs
    wire [31:0] result;
    wire valid;

    // Instantiate the FPU module
    fpu_4stage uut (
        .clk(clk),
        .rst(rst),
        .opA(opA),
        .opB(opB),
        .opSelect(opSelect),
        .result(result),
        .valid(valid)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Test sequence
    initial begin
        // Initialize inputs
        rst = 1;
        opA = 32'b0;
        opB = 32'b0;
        opSelect = 0;

        // Apply reset
        #10 rst = 0;

        // Test 1: FADD (10.5 + 5.25)
        opA = 32'h41280000; // 10.5 in IEEE-754
        opB = 32'h40a80000; // 5.25 in IEEE-754
        opSelect = 0;       // FADD
//        opA = 32'h00000000; // 10.5 in IEEE-754
//        opB = 32'h00000000; // 5.25 in IEEE-754
//        opSelect = 0;       // FADD

        // Wait for 4 clock cycles
        #40;
        $display("Test 1 - FADD Result: %h, Valid: %b", result, valid);

        // Test 2: FSUB (15.75 - 4.0)
        opA = 32'h417C0000; // 15.75 in IEEE-754
        opB = 32'h40800000; // 4.0 in IEEE-754
        opSelect = 1;       // FSUB

        // Wait for 4 clock cycles
        #40;
        $display("Test 2 - FSUB Result: %h, Valid: %b", result, valid);

        // Finish simulation
        #20 $finish;
    end

endmodule
