`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2024 08:49:11 PM
// Design Name: 
// Module Name: tb_reg_file
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


//Testbench for register file
module RegisterFile_tb;

    // Inputs
    reg clk;
    reg reset;
    reg [3:0] read_reg1, read_reg2, write_reg;
    reg [31:0] write_data;
    reg reg_write;
    reg [4:0] cc_flags;

    // Outputs
    wire [31:0] reg_data1, reg_data2;
    wire [31:0] pc, sp;

    // Instantiate the RegisterFile
    RegisterFile uut (
        .clk(clk),
        .reset(reset),
        .read_reg1(read_reg1),
        .read_reg2(read_reg2),
        .write_reg(write_reg),
        .write_data(write_data),
        .reg_write(reg_write),
        .cc_flags(cc_flags),
        .reg_data1(reg_data1),
        .reg_data2(reg_data2),
        .pc(pc),
        .sp(sp)
    );

    // Clock generation
    always #5 clk = ~clk;  // Toggle clock every 5 time units

    initial begin
        // Initialize inputs
        clk = 0;
        reset = 1;  // Start with reset active
        reg_write = 0;
        write_data = 0;
        read_reg1 = 0;
        read_reg2 = 0;
        write_reg = 0;
        cc_flags = 0;

        #10 reset = 0;  // Deassert reset after 10 time units

        // Test writing to registers
        #10 write_reg = 4'b0010; write_data = 32'd123; reg_write = 1; // Write 123 to R2
        #10 write_reg = 4'b0011; write_data = 32'd456; reg_write = 1; // Write 456 to R3
        #10 write_reg = 4'b0100; write_data = 32'd789; reg_write = 1; // Write 789 to R4

        // Test reading from registers
        #10 reg_write = 0; read_reg1 = 4'b0010; read_reg2 = 4'b0011; // Read R2 and R3
        #10 $display("Read R2 = %d, R3 = %d", reg_data1, reg_data2); // Expect 123 and 456

        // Test reading from R0 (PC) and R1 (SP)
        #10 read_reg1 = 4'b0000; read_reg2 = 4'b0001;  // Read PC (R0) and SP (R1)
        #10 $display("Read PC = %d, SP = %d", reg_data1, reg_data2); // Expect PC and SP values

        // Test updating the Condition Code (CC) register
        #10 cc_flags = 5'b10101;  // Set some flags
        #10 $display("CC Flags updated to: %b", cc_flags);

        // Test program counter increment
        #20 $display("PC after increment: %d", pc);

        
        #50 $finish;
    end
endmodule
