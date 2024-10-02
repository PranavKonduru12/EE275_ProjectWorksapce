`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/01/2024 05:09:46 PM
// Design Name: 
// Module Name: tb_MultiBitAdder
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


module tb_MultiBitAdder();
    
    reg     [3:0] An, Bn; 
    reg     Cin_n;
    wire    [3:0] Sn; 
    wire    Cout_n;
    
    FourBitAdder myFourAdderTB(An, Bn, 
    Cin_n, Sn , Cout_n
    );
    
    initial 
        begin
            //An[0] = 0; Bn[0] = 0; An[1] = 0; Bn[1] = 0; Cin_n = 0;
            An[3:0] = 4'b0000; Bn[3:0] = 4'b0000; Cin_n = 1;
            #10
            $finish;
        end
endmodule
