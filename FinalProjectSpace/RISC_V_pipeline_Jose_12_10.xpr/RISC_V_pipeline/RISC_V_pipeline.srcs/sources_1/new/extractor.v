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
  input wire [31:0] ins,          // 32-bit instruction
  output reg [63:0] imm_data      // 64-bit immediate data
);

  reg sel1, sel2;

  always @(ins) begin
    // Decode selectors
    sel1 = ins[5];
    sel2 = ins[4];

    // Extract immediate based on selectors
    if (sel1) begin
      // Branch instructions
      imm_data[9:0] <= {ins[30:25], ins[11:8]};
      imm_data[63:10] <= {54{ins[30]}};
      $display("Extractor: Branch immediate extracted: %h", imm_data);
    end else begin
      if (sel2) begin
        // Store instructions
        imm_data[11:0] <= {ins[31:25], ins[11:7]};
        imm_data[63:12] <= {52{ins[31]}};
        $display("Extractor: Store immediate extracted: %h", imm_data);
      end else begin
        // Load or arithmetic with immediate
        imm_data[11:0] <= ins[31:20];
        imm_data[63:12] <= {52{ins[31]}};
        $display("Extractor: Load/Arithmetic immediate extracted: %h", imm_data);
      end
    end
  end

endmodule


//module extractor(
//  input wire [31:0] ins,
//  output reg [63:0] imm_data
//);
//  reg sel1, sel2;
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
//endmodule 

