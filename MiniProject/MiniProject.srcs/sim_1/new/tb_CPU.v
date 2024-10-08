`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2024 07:51:28 PM
// Design Name: 
// Module Name: tb_CPU
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

    // Testbench signals
    reg clk;
    reg reset;
    reg [31:0] instruction;
    reg [31:0] memory_data_in;
    wire [31:0] memory_address;
    wire [31:0] memory_data_out;
    wire mem_write;
    wire mem_read;
    wire [31:0] pc;

    // Instantiate the CPU module
    CPU cpu (
        .clk(clk),
        .reset(reset),
        .instruction(instruction),
        .memory_data_in(memory_data_in),
        .memory_address(memory_address),
        .memory_data_out(memory_data_out),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .pc(pc)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Test sequence
    initial begin
        // Initialize signals
        reset = 1;  // Assert reset
        instruction = 32'b0;  // No instruction initially
        memory_data_in = 32'b0;  // No data initially

        // Wait for a few clock cycles
        #10 reset = 0;  // Deassert reset

//        // Load immediate into R2
//        instruction = {4'b0010, 4'b0000, 4'b0010, 16'd15}; // LOAD IMMEDIATE R2, 15
//        #10;

        // Add R1 (0) and R2 (15) -> R3
        instruction = {4'b0000, 4'b0001, 4'b0010, 4'b0011}; // ADD R3, R1, R2
        #10;

//        // Store R3 into memory address 0x0000_0004
//        instruction = {4'b0011, 4'b0011, 4'b0000, 16'd4}; // STORE R3, 0x0000_0004
//        memory_data_in = 32'd10; // Some data to store
//        #10;

//        // Load from memory address 0x0000_0004 into R4
//        instruction = {4'b0100, 4'b0000, 4'b0000, 16'd4}; // LOAD R4, 0x0000_0004
//        #10;

//        // Check if R4 is equal to R3 (should be true)
//        instruction = {4'b1000, 4'b0011, 4'b0011, 16'b0}; // EQUAL R3, R3
//        #10;

//        // Add R4 (should still be R4) and R3 -> R5
//        instruction = {4'b0000, 4'b0011, 4'b0011, 4'b0101}; // ADD R5, R4, R3
//        #10;

        // End of test
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time: %0t | PC: %h | Mem Addr: %h | Mem Write: %b | Mem Read: %b | Data Out: %d | Data In: %d", 
                  $time, pc, memory_address, mem_write, mem_read, memory_data_out, memory_data_in);
    end

endmodule

