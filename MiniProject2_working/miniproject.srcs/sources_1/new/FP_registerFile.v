`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2024 01:07:47 PM
// Design Name: 
// Module Name: FP_registerFile
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


module fp_register_file(
    input wire clk,
    input wire rst,
    input wire [4:0] read_reg1, // 5-bit address for 32 registers
    input wire [4:0] read_reg2,
    input wire [4:0] write_reg,
    input wire [31:0] write_data,
    input wire write_enable,
    output reg [31:0] read_data1,
    output reg [31:0] read_data2,
    input wire [31:0] scalar_write_data, // Scalar register write
    input wire scalar_write_enable,
    output reg [31:0] scalar_data // Scalar register read
);

    // 32 FP Registers, each 32 bits wide
    reg [31:0] registers [0:31];
    reg [31:0] scalar_register; // Additional scalar register

    // Read operations
    always @(*) begin
        if (!rst) begin
            read_data1 = registers[read_reg1];
            read_data2 = registers[read_reg2];
        end else begin
            read_data1 = 32'b0;
            read_data2 = 32'b0;
        end
    end

    // Scalar register read
    always @(*) begin
        if (!rst) begin
            scalar_data = scalar_register;
        end else begin
            scalar_data = 32'b0;
        end
    end

    // Write operation
    integer i;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
           // integer i;
            for (i = 0; i < 32; i = i + 1) begin
                registers[i] <= 32'b0;
            end
            scalar_register <= 32'b0;
        end else begin
            if (write_enable) begin
                registers[write_reg] <= write_data;
            end
            if (scalar_write_enable) begin
                scalar_register <= scalar_write_data;
            end
        end
    end

endmodule
