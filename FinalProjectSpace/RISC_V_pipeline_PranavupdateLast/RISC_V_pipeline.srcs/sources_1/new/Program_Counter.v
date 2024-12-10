`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2024 11:54:08 PM
// Design Name: 
// Module Name: Program_Counter
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
module Program_Counter(
  input wire clk, reset, 
  input wire [63:0] PC_In,
  output reg [63:0] PC_Out
);
  //always @(posedge reset or posedge clk)
  always @(posedge clk or posedge reset)
  begin
    if(reset)
      PC_Out <= 64'd0;  // Reset to address 0
    else
      PC_Out <= PC_In;  // Update PC on clock edge
  end
endmodule 


