`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2024 10:54:55 PM
// Design Name: 
// Module Name: cpu_tb
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


module cpu_tb;
    // Inputs
    reg clk;
    reg reset;

    // Outputs
    wire [31:0] alu_result;

    // Instantiate the CPU
    cpu uut (
        .clk(clk),
        .reset(reset),
        .alu_result(alu_result)
    );

    // Clock generation
    always #5 clk = ~clk;  // Toggle clock every 5 time units

    initial begin
        // Initialize inputs
        clk = 0;
        reset = 1;  // Start with reset active

        // Print initial state
        $display("Starting CPU Testbench...");

        // Deassert reset after 10 time units
        #10 reset = 0;

        // Run simulation for a few clock cycles
        #100;

        // Finish the simulation
        $finish;
    end

    // Monitor ALU result and PC values
    always @(posedge clk) begin
        $display("Time: %0d, ALU Result: %d", $time, alu_result);
    end
endmodule

