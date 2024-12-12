`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2024 11:47:15 PM
// Design Name: 
// Module Name: MEMRegister
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
module MEMRegister(
  input wire [63:0] PC_in,
             [63:0] aluResult_in,
             [63:0] data2_in,
             [31:0] fpuResult_in,    // Floating-point result
             [4:0] rd_in,
             wire Branch_in, MemRead_in, MemtoReg_in, MemWrite_in, RegWrite_in, zero_in,
             wire FADD_FSUB_in,      // FPU add/sub control
             wire fpuException_in,   // FPU exception flag
             clk, reset,
  output reg [63:0] PC_out,
         reg [63:0] aluResult_out,
         reg [63:0] data2_out,
         reg [31:0] fpuResult_out,  // Floating-point result
         reg [4:0] rd_out,
         reg Branch_out, reg MemRead_out, reg MemtoReg_out, reg MemWrite_out, reg RegWrite_out, reg zero_out,
         reg FADD_FSUB_out,         // FPU add/sub control
         reg fpuException_out       // FPU exception flag
);

  always @(posedge reset or posedge clk) begin
    if (reset) begin
        PC_out <= 64'b0;
        aluResult_out <= 64'b0;
        data2_out <= 64'b0;
        fpuResult_out <= 32'b0;    // Reset FPU result
        rd_out <= 5'b0;
        Branch_out <= 1'b0;
        MemRead_out <= 1'b0;
        MemtoReg_out <= 1'b0;
        MemWrite_out <= 1'b0;
        RegWrite_out <= 1'b0;
        zero_out <= 1'b0;
        FADD_FSUB_out <= 1'b0;    // Reset FPU control signal
        fpuException_out <= 1'b0; // Reset FPU exception flag
    end else begin
        PC_out <= PC_in;
        aluResult_out <= aluResult_in;
        data2_out <= data2_in;
        fpuResult_out <= fpuResult_in; // Pass FPU result
        rd_out <= rd_in;
        Branch_out <= Branch_in;
        MemRead_out <= MemRead_in;
        MemtoReg_out <= MemtoReg_in;
        MemWrite_out <= MemWrite_in;
        RegWrite_out <= RegWrite_in;
        zero_out <= zero_in;
        FADD_FSUB_out <= FADD_FSUB_in; // Pass FPU control signal
        fpuException_out <= fpuException_in; // Pass FPU exception flag
    end
  end
endmodule

//module MEMRegister(
//  input wire [63:0] PC_in,
//             [63:0] aluResult_in,
//             [63:0] data2_in,
//             [4:0] rd_in,
//             wire Branch_in, MemRead_in, MemtoReg_in, MemWrite_in, RegWrite_in, zero_in,
//             clk, reset,
//  output reg [63:0] PC_out,
//         reg [63:0] aluResult_out,
//         reg [63:0] data2_out,
//         reg [4:0] rd_out,
//         reg Branch_out, reg MemRead_out, reg MemtoReg_out, reg MemWrite_out, reg RegWrite_out, reg zero_out

//);
//  always @(posedge reset or posedge clk)
//  begin
//    if(reset)
//      begin
//        PC_out <= 64'b0;
//        aluResult_out <= 64'b0;
//        data2_out <= 64'b0;
//        rd_out <= 5'b0;
//        Branch_out <= 1'b0;
//        MemRead_out <= 1'b0;
//        MemtoReg_out <= 1'b0;
//        MemWrite_out <= 1'b0;
//        RegWrite_out <= 1'b0;
//        zero_out <= 1'b0;
//      end
//    else
//      begin
//        PC_out <= PC_in;
//        aluResult_out <= aluResult_in;
//        data2_out <= data2_in;
//        rd_out <= rd_in;
//        Branch_out <= Branch_in;
//        MemRead_out <= MemRead_in;
//        MemtoReg_out <= MemtoReg_in;
//        MemWrite_out <= MemWrite_in;
//        RegWrite_out <= RegWrite_in;
//        zero_out <= zero_in;
//      end
//  end
//endmodule 
