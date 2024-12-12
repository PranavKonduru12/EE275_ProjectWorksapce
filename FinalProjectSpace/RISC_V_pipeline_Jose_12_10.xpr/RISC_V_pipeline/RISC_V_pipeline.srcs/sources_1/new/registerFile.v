`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2024 11:56:03 PM
// Design Name: 
// Module Name: registerFile
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
module registerFile(
  input wire [4:0] rs1,           // Source register 1
             [4:0] rs2,           // Source register 2
             [4:0] rd,            // Destination register
             [63:0] writeData,    // Data to be written
             [31:0] fpuWriteData, // FPU data to be written
             wire regWrite,       // Write enable signal for integer data
             wire fpuRegWrite,    // Write enable signal for floating-point data
             clk, reset,
  output wire [63:0] ReadData1,   // Integer read data 1
              [63:0] ReadData2,   // Integer read data 2
              [31:0] fpuReadData1,// Floating-point read data 1
              [31:0] fpuReadData2 // Floating-point read data 2
);

  reg [63:0] registerArr [31:0];   // Integer registers
  reg [31:0] fpuRegisterArr [31:0]; // Floating-point registers
  integer i;
  always @(posedge reset or posedge clk) begin
    if (reset) begin
      //integer i;
      for (i = 0; i < 32; i = i + 1) begin
        registerArr[i] = 64'd0;
        fpuRegisterArr[i] = 32'd0;
      end
    end else begin
      if (regWrite) begin
        registerArr[rd] <= writeData; // Write to integer registers
      end
      if (fpuRegWrite) begin
        fpuRegisterArr[rd] <= fpuWriteData; // Write to floating-point registers
      end
    end
  end

  assign ReadData1 = registerArr[rs1];       // Read integer data 1
  assign ReadData2 = registerArr[rs2];       // Read integer data 2
  assign fpuReadData1 = fpuRegisterArr[rs1]; // Read floating-point data 1
  assign fpuReadData2 = fpuRegisterArr[rs2]; // Read floating-point data 2

endmodule




//module registerFile(
//  input wire [4:0] rs1, [4:0] rs2, [4:0] rd, [63:0] writeData, wire regWrite, clk, reset,
//  output wire [63:0] ReadData1, wire [63:0] ReadData2 
//);
//  reg [63:0] registerArr [31:0];
//  always @(posedge reset or posedge clk)
//  begin
//    if(reset)
//      begin
//        registerArr[0] = 64'd0;
//        registerArr[1] = 64'd0;
//        registerArr[2] = 64'd0;
//        registerArr[3] = 64'd0;
//        registerArr[4] = 64'd0;
//        registerArr[5] = 64'd0;
//        registerArr[6] = 64'd0;
//        registerArr[7] = 64'd0;
//        registerArr[8] = 64'd0;
//        registerArr[9] = 64'd0;
//        registerArr[10] = 64'd15;
//        registerArr[11] = 64'd0;
//        registerArr[12] = 64'd0;
//        registerArr[13] = 64'd0;
//        registerArr[14] = 64'd0;
//        registerArr[15] = 64'd0;
//        registerArr[16] = 64'd0;
//        registerArr[17] = 64'd0;
//        registerArr[18] = 64'd0;
//        registerArr[19] = 64'd0;
//        registerArr[20] = 64'd0;
//        registerArr[21] = 64'd4;
//        registerArr[22] = 64'd0;
//        registerArr[23] = 64'd0;
//        registerArr[24] = 64'd0;
//        registerArr[25] = 64'd0;
//        registerArr[26] = 64'd0;
//        registerArr[27] = 64'd0;
//        registerArr[28] = 64'd0;
//        registerArr[29] = 64'd0;
//        registerArr[30] = 64'd0;
//        registerArr[31] = 64'd0;
//      end
//    else
//    begin
//      if(regWrite)
//      begin
//        registerArr[rd] <= writeData;
//      end
//    end
//  end
//  assign ReadData1 = registerArr[rs1];
//  assign ReadData2 = registerArr[rs2];
//endmodule 

