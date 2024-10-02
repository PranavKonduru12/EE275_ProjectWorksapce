`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/28/2024 06:54:36 PM
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


//module tb();
//    reg a0, a1, b0, b1, cin;
//    wire sum0, sum1, cout;  
    
    
//    TwoBitFA mytwoTB(.a0(a0), .a1(a1), .b0(b0), .b1(b1), .cin(cin), .sum0(sum0), .sum1(sum1), .cout(cout));  
        
        
        
//    initial
//        begin
        
//            a0 = 1'b1;
//            a1 = 1'b0;
//            b0 = 1'b1;
//            b1 = 1'b0;
//            cin = 1'b1;
//            #10;
//            $stop;
//        end
    
//endmodule

//module tb(); 
//    reg a0, a1, b0, b1, cin;
//    wire sum0, sum1, cout;  

//    TwoBitFA mytwoTB(.a0(a0), .a1(a1), .b0(b0), .b1(b1), .cin(cin), .sum0(sum0), .sum1(sum1), .cout(cout));  

//    initial begin
//        // Test case
//        a0 = 1'b1;
//        a1 = 1'b0;
//        b0 = 1'b1;
//        b1 = 1'b0;
//        cin = 1'b1;

//        #10; // Wait for 10 time units
//        $stop; // Stop the simulation
//    end

//endmodule

module tb();
    reg a0, a1, b0, b1, cin;
    wire sum0, sum1, cout;
    TwoBitFA mytwoTB(.a0(a0), .a1(a1), .b0(b0), .b1(b1), .cin(cin), .sum0(sum0), .sum1(sum1), .cout(cout));
    
    initial begin
        // Test case
        a0 = 1'b1;
        a1 = 1'b0;
        b0 = 1'b1;
        b1 = 1'b0;
        cin = 1'b1;

        #10; // Wait for 10 time units
        $stop; // Stop the simulation
    end
endmodule   

