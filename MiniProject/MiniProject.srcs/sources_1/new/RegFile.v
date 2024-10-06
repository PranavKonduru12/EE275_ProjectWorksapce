`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2024 12:43:15 PM
// Design Name: 
// Module Name: RegFile
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


module regfile(
    input clk,
    input [3:0] readReg1,   //Address for first register read
    input [3:0] readReg2,   //Address for second register read   
    input [3:0] writeReg,   //Address for write register 
    input [31:0] writeData,
    input write,            //Flag to allow register writing
    output [31:0] readData1,//Read from first register
    output [31:0] readData2 //Read from second register
    );                      //Read two registers, but only write one register at a time
    
    reg [31:0] register [15:0];
    
    integer i;
    initial begin
        for (i=0;i<15;i=i+1)
        register[i] = 0;
    end
    
    assign readData1 = (register[readReg1]);
    assign readData2 = (register[readReg2]);
//    assign readData1 = $signed(register[readReg1]);
//    assign readData2 = $signed(register[readReg2]);
    
    always @(posedge clk)begin
        if (write)begin
            register[writeReg] <= writeData;
//            if (writeReg != 0)begin
//                register[writeReg] <= writeData;
////                register[writeReg] <= $signed(writeData);
//            end
        end
    end    
endmodule
