`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2024 12:50:57 AM
// Design Name: 
// Module Name: AITRy
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


module TwoBitAdder (
    input A0, B0, A1, B1, Cin,
    output S0, S1, Cout
);

// First bit addition (A0 + B0 + Cin)
wire w1, w2, w3;

// Sum for first bit
xor (w1, A0, B0);  // XOR between A0 and B0
xor (S0, w1, Cin); // XOR with Cin for sum

// Carry-out from first bit
and (w2, A0, B0);   // AND between A0 and B0
and (w3, w1, Cin);  // AND between (A0 XOR B0) and Cin
or  (carry0, w2, w3); // OR to get the carry-out

// Second bit addition (A1 + B1 + carry0)
wire w4, w5, w6;

// Sum for second bit
xor (w4, A1, B1);   // XOR between A1 and B1
xor (S1, w4, carry0); // XOR with carry0 for sum

// Carry-out from second bit (final Cout)
and (w5, A1, B1);    // AND between A1 and B1
and (w6, w4, carry0); // AND between (A1 XOR B1) and carry0
or  (Cout, w5, w6);  // OR to get the final carry-out

endmodule

