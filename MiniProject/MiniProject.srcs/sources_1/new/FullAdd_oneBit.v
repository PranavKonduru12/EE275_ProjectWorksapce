`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2024 03:47:48 PM
// Design Name: 
// Module Name: FullAdd_oneBit
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


module fulladd(
    output sum, cout, 
    input a, b, cin
);
    wire s1, c1, c2;
    
    xor (s1, a, b);
    and (c1, a, b);
    xor (sum, s1, cin);
    and (c2, s1, cin);
    or (cout, c1, c2);
endmodule
