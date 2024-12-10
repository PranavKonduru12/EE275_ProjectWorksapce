`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2024 11:58:18 PM
// Design Name: 
// Module Name: tb
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

module tb();

  reg clk, reset;

  RISC_V_Processor uut(.clk(clk), .reset(reset));
  initial
  begin
    clk = 0;
    reset = 1;
    #5 reset = 0;
  end
  
  always
    #5 clk = ~clk;
    
endmodule
