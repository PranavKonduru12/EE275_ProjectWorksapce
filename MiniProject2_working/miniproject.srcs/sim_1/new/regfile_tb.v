`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/07/2024 11:27:58 PM
// Design Name: 
// Module Name: regfile_tb
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


module tb_RegFile();

    reg clk;                             
    reg [3:0] read_reg1, read_reg2;      
    reg [3:0] write_reg;                 
    reg [31:0] write_data;               
    reg reg_write;                       
    reg [4:0] cc_flags;                  
    wire [31:0] reg_data1, reg_data2, pc, sp;

    RegisterFile myReg(
    clk,                              
    read_reg1, read_reg2,       
    write_reg,                  
    write_data,                
    reg_write,                        
    cc_flags,                   
    reg_data1, reg_data2, 
    pc,                 
    sp 
                 
    );
    
    //clk = 0;
    always begin
        //clk = 0;
        #10 clk = ~clk;
    end
    
    initial begin
        clk = 1;
        
            cc_flags = 5'b00000; read_reg1 = 4'd0; read_reg2 = 4'd1; reg_write = 0; write_reg = 4'd0; write_data = 32'd1;
        #20 cc_flags = 5'b00001; read_reg1 = 4'd0; read_reg2 = 4'd1; reg_write = 1; write_reg = 4'd0; write_data = 32'd1; 
        #20 read_reg1 = 4'd0; read_reg2 = 4'd1; reg_write = 0; write_reg = 4'd1; write_data = 32'd2;
        #20 read_reg1 = 4'd0; read_reg2 = 4'd2; reg_write = 1; write_reg = 4'd2; write_data = 32'd3;
        #20 read_reg1 = 4'd0; read_reg2 = 4'd1;
        #20 read_reg1 = 4'd0; read_reg2 = 4'd1; reg_write = 1; write_reg = 4'd1; write_data = 32'd3;
         
        
    end
    
endmodule
