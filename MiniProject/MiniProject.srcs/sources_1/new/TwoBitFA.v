`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/28/2024 06:48:54 PM
// Design Name: 
// Module Name: TwoBitFA
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



    

module TwoBitFA ( 
    input a0, a1, b0, b1, cin, 
    output sum0, sum1, cout 
    );    

    wire s0, sl, s2, s3, s4;
    xor (s0, a0, b0); 
    xor (sum0, s0, cin); 
    
    xor (s1, a1, b1); 
    xor (sum1, s1, cout); 
    
    and (s2, a1, b1);
    xor (s3, a1, b1);
    and (s4, s3, cin);
    or  (cout, s2, s4);
    
    //assign cout = cout_in; 
endmodule
    
    

//module TwoBitFA (
//    input a0, a1, b0, b1, cin,
//    output sum0, sum1, cout
//);    

//    wire s0, s1, s2, s3, s4, c1;

//    // First bit addition
//    xor (s0, a0, b0); 
//    xor (sum0, s0, cin); 

//    // Carry for the first bit
//    and (s2, s0, cin); // carry from first bit
//    and (s3, a0, b0);  // carry from second bit
//    or  (c1, s2, s3);  // total carry to second bit

//    // Second bit addition
//    xor (sum1, a1, b1); 
//    xor (sum1, sum1, c1); // adding carry from first bit
    
//    // Final carry out
//    and (s4, a1, b1);
//    or  (cout, c1, s4);

//endmodule
