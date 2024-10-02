`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/01/2024 03:18:36 PM
// Design Name: 
// Module Name: MultiBitAdder
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


module FourBitAdder(
    input   [3:0] An, Bn, 
    input   Cin_n,
    output  [3:0] Sn, 
    output  Cout_n
    );
    wire c;
    
    TwoBitAdder myTwoBitOne(.A0(An[0]), .B0(Bn[0]), .A1(An[1]), .B1(Bn[1]), .Cin(Cin_n), 
    .S0(Sn[0]), .S1(Sn[1]), .Cout(c)
    );
    
    TwoBitAdder myTwoBitTwo(.A0(An[2]), .B0(Bn[2]), .A1(An[3]), .B1(Bn[3]), .Cin(c), 
    .S0(Sn[2]), .S1(Sn[3]), .Cout(Cout_n)
    );
    
endmodule
