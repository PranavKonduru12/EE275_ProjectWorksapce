`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2024 11:42:47 PM
// Design Name: 
// Module Name: IDRegister
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
module IDRegister(
  input wire [63:0] PC_in, [31:0] ins_in, wire clk, reset,
  output reg [63:0] PC_out, reg [31:0] ins_out 
);
  //always @(posedge reset or posedge clk)
  always @(posedge clk or posedge reset)
  begin
    if(reset)
      begin
        ins_out <= 32'b0;
        PC_out <= 64'b0;
      end
    else
      begin
        PC_out <= PC_in;
        ins_out <= ins_in;
      end
  end
endmodule 
