`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2024 02:40:12 PM
// Design Name: 
// Module Name: OneBitAdder
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


module OneBitAdder(
    input a_full, b_full, cin,
    output sum_full, cout
    );
    wire cin_wire, sum_wire, cout_wire;
    
    Half_Adder first_half(.a(a_full), .b(b_full), 
    .sum(sum_wire), .carry(cin_wire));
    
    Half_Adder second_half(.a(sum_wire), .b(cin), 
    .sum(sum_full), .carry(cout_wire));
    
    or(cout, cout_wire, cin_wire);
endmodule
