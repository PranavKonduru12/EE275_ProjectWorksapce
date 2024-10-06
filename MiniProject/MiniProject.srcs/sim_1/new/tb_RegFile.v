`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2024 01:08:24 PM
// Design Name: 
// Module Name: tb_RegFile
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


module tb_RegFile();

    reg clk;
    reg [3:0] readReg1;
    reg [3:0] readReg2;
    reg [3:0] writeReg;
    reg [31:0] writeData;
    reg write;
    wire [31:0] readData1;
    wire [31:0] readData2;

    regfile myReg(
    clk,
    readReg1,
    readReg2,
    writeReg,
    writeData,
    write,
    readData1,
    readData2
    );
    
    //clk = 0;
    always begin
        //clk = 0;
        #10 clk = ~clk;
    end
    
    initial begin
        clk = 1;
        
            readReg1 = 4'd0; readReg2 = 4'd1; write = 0; writeReg = 4'd0; writeData = 32'd1;
        #20 readReg1 = 4'd0; readReg2 = 4'd1; write = 1; writeReg = 4'd0; writeData = 32'd1; 
        #20 readReg1 = 4'd0; readReg2 = 4'd1; write = 0; writeReg = 4'd1; writeData = 32'd2;
        #20 readReg1 = 4'd0; readReg2 = 4'd1; write = 1; writeReg = 4'd0; writeData = 32'd3;
        #20 readReg1 = 4'd0; readReg2 = 4'd1;
        #20 readReg1 = 4'd0; readReg2 = 4'd1; write = 1; writeReg = 4'd1; writeData = 32'd3;
         
        
    end
    
endmodule
