`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2024 09:33:28 PM
// Design Name: 
// Module Name: tb_instructionMemory
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


module instruction_memory_tb;

    // Inputs
    reg [31:0] addr;

    // Outputs
    wire [31:0] instruction;

    // Instantiate the Instruction Memory module
    instruction_memory uut (
        .addr(addr),
        .instruction(instruction)
    );

    // Test procedure
    initial begin
        // Display header
        $display("Time (ns)   | Address (addr) | Fetched Instruction");
        $display("---------------------------------------------");

        // Initialize Address
        addr = 32'b0;

        // Monitor values and step through different addresses to simulate instruction fetch
        #10 addr = 32'd0;  // Fetch instruction at address 0
        #10 addr = 32'd1;  // Fetch instruction at address 1
        #10 addr = 32'd2;  // Fetch instruction at address 2
        #10 addr = 32'd3;  // Fetch instruction at address 3
        #10 addr = 32'd4;  // Fetch instruction at address 4
        #10 addr = 32'd5;  // Fetch instruction at address 5
        #10 addr = 32'd6;  // Fetch instruction at address 6
        #10 addr = 32'd7;  // Fetch instruction at address 7
        #10 addr = 32'd8;  // Fetch instruction at address 8
        #10 addr = 32'd9;  // Fetch instruction at address 9

        #10 $finish;  // End the simulation
    end

    // Monitor and display instruction fetch
    always @(addr or instruction) begin
        $display("%0t ns   | Address: %0d     | Instruction: %b", $time, addr, instruction);
    end

endmodule
