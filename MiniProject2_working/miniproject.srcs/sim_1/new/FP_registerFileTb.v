`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2024 01:10:29 PM
// Design Name: 
// Module Name: FP_registerFileTb
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


module register_file_tb;
    // Inputs
    reg clk;
    reg rst;
    reg [4:0] read_reg1;
    reg [4:0] read_reg2;
    reg [4:0] write_reg;
    reg [31:0] write_data;
    reg write_enable;
    reg [31:0] scalar_write_data;
    reg scalar_write_enable;

    // Outputs
    wire [31:0] read_data1;
    wire [31:0] read_data2;
    wire [31:0] scalar_data;

    // Instantiate the Register File module
    fp_register_file uut (
        .clk(clk),
        .rst(rst),
        .read_reg1(read_reg1),
        .read_reg2(read_reg2),
        .write_reg(write_reg),
        .write_data(write_data),
        .write_enable(write_enable),
        .read_data1(read_data1),
        .read_data2(read_data2),
        .scalar_write_data(scalar_write_data),
        .scalar_write_enable(scalar_write_enable),
        .scalar_data(scalar_data)
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
        write_enable = 0;
        scalar_write_enable = 0;
        read_reg1 = 5'b0;
        read_reg2 = 5'b0;
        write_reg = 5'b0;
        write_data = 32'b0;
        scalar_write_data = 32'b0;

        // Apply reset
        #10 rst = 0;

        // Write to register 1
        #10;
        write_enable = 1;
        write_reg = 5'd1;
        write_data = 32'h12345678;

        // Write to scalar register
        #10;
        scalar_write_enable = 1;
        scalar_write_data = 32'h87654321;

        // Disable write enables
        #10;
        write_enable = 0;
        scalar_write_enable = 0;

        // Read from register 1 and scalar register
        #10;
        read_reg1 = 5'd1;

        // Wait and observe
        #20;
        $display("Read Data 1: %h", read_data1);
        $display("Scalar Data: %h", scalar_data);

        // Write to register 2
        #10;
        write_enable = 1;
        write_reg = 5'd2;
        write_data = 32'hAABBCCDD;

        // Disable write enable
        #10;
        write_enable = 0;

        // Read from register 1 and register 2
        #10;
        read_reg1 = 5'd1;
        read_reg2 = 5'd2;

        // Wait and observe
        #20;
        $display("Read Data 1: %h", read_data1);
        $display("Read Data 2: %h", read_data2);

        // Finish simulation
        #20 $finish;
    end

endmodule
