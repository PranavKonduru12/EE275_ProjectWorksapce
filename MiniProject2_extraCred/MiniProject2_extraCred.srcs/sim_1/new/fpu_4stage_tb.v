`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2024 09:47:56 PM
// Design Name: 
// Module Name: fpu_4stage_tb
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
    reg opSelect; // 0 for FADD, 1 for FSUB

    // Outputs
    wire [31:0] result;
    wire valid;
    wire overflow_flag, underflow_flag, nan_flag;

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Instantiate the FPU 4-stage module
    fpu_4stage uut (
        .clk(clk),
        .rst(rst),
        .opA(opA),
        .opB(opB),
        .opSelect(opSelect),
        .result(result),
        .valid(valid),
        .overflow_flag(overflow_flag), 
        .underflow_flag(underflow_flag), 
        .nan_flag(nan_flag)
    );

    // Test sequence
    initial begin
        // Initialize inputs
        rst = 1;
        opA = 32'h00000000;
        opB = 32'h00000000;
        opSelect = 0;

        // Apply reset
        #20 rst = 0;

        // Test Case 1: FADD of 1.0 + 2.0
        #10;
        opA = 32'h3F800000; // 1.0 in IEEE 754
        opB = 32'h40000000; // 2.0 in IEEE 754
        opSelect = 0; // FADD
        #20;

        // Test Case 2: FSUB of 5.0 - 3.0
        #10;
        opA = 32'h40A00000; // 5.0 in IEEE 754
        opB = 32'h40400000; // 3.0 in IEEE 754
        opSelect = 1; // FSUB
        #20;

        // Test Case 3: FADD of -2.5 + 3.5
        #10;
        opA = 32'hC0200000; // -2.5 in IEEE 754
        opB = 32'h40600000; // 3.5 in IEEE 754
        opSelect = 0; // FADD
        #20;

        // Test Case 4: FSUB of 10.0 - 15.0
        #10;
        opA = 32'h41200000; // 10.0 in IEEE 754
        opB = 32'h41700000; // 15.0 in IEEE 754
        opSelect = 1; // FSUB
        #20;
        
        // Test Case 5: FSUB of 10.0 - 35.0
        #10;
        opA = 32'h41200000; // 10.0 in IEEE 754
        opB = 32'hC20C0000; // 35.0 in IEEE 754
        opSelect = 1; // FSUB
        #20;

        // Finish simulation
        #500 $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time: %0dns, opA: %h, opB: %h, opSelect: %b, Result: %h, Valid: %b", 
                 $time, opA, opB, opSelect, result, valid);
    end

endmodule

