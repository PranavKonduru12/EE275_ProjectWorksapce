`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2024 11:38:58 PM
// Design Name: 
// Module Name: extractor
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
module extractor(
  input wire [31:0] ins,
  output reg [63:0] imm_data
);
  //reg sel1, sel2;
//  always @(ins)
//  begin
//    sel1 = ins[5];
//    sel2 = ins[4];
//    if(sel1)
//    begin
//      imm_data[9:0] <= {ins[30:25] , ins[11:8]};
//      imm_data[63:10] <= {54{ins[30]}};
//    end
//    else
//    begin
//      if(sel2)
//      begin
//        imm_data[11:0] <= {ins[31:25] , ins[11:7]};
//        imm_data[63:12] <= {52{ins[31]}};  
//      end
//      else
//      begin
//        imm_data[11:0] <= ins[31:20];
//        imm_data[63:12] <= {52{ins[31]}};
//      end
//    end
//  end
    //As these values do not need to trigger at clock edge
    //they are assigned to the variables with "=" instead of "<="
    always @(ins) begin
    if (ins[5]) begin // If the 5th bit (sel1) is 1
      imm_data[9:0] = {ins[30:25], ins[11:8]};  // Immediate format for I-type
      imm_data[63:10] = {54{ins[30]}};           // Sign extension
    end else if (ins[4]) begin // If the 4th bit (sel2) is 1
      imm_data[11:0] = {ins[31:25], ins[11:7]};  // Immediate format for S-type
      imm_data[63:12] = {52{ins[31]}};           // Sign extension
    end else begin // Default case (U-type or J-type)
      imm_data[11:0] = ins[31:20];               // Immediate format for U-type (lui, auipc)
      imm_data[63:12] = {52{ins[31]}};           // Sign extension
    end
  end
endmodule 

