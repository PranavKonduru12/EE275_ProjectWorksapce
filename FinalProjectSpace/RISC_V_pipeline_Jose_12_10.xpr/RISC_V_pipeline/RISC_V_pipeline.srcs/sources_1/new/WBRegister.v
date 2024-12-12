module WBRegister(
  input wire [63:0] aluResult_in,
             [63:0] memData_in,
             [31:0] fpuResult_in,   // Floating-point result
             [4:0] rd_in,
             wire MemtoReg_in, RegWrite_in,
             wire fpuException_in,  // FPU exception flag
             clk, reset,
  output reg [63:0] aluResult_out,
         reg [63:0] memData_out,
         reg [31:0] fpuResult_out, // Floating-point result
         reg [4:0] rd_out,
         reg MemtoReg_out, reg RegWrite_out,
         reg fpuException_out     // FPU exception flag
);

  always @(posedge reset or posedge clk) begin
    if (reset) begin
        aluResult_out <= 64'b0;
        memData_out <= 64'b0;
        fpuResult_out <= 32'b0;    // Reset FPU result
        rd_out <= 5'b0;
        MemtoReg_out <= 1'b0;
        RegWrite_out <= 1'b0;
        fpuException_out <= 1'b0; // Reset FPU exception flag
    end else begin
        aluResult_out <= aluResult_in;
        memData_out <= memData_in;
        fpuResult_out <= fpuResult_in; // Pass FPU result
        rd_out <= rd_in;
        MemtoReg_out <= MemtoReg_in;
        RegWrite_out <= RegWrite_in;
        fpuException_out <= fpuException_in; // Pass FPU exception flag
    end
  end
endmodule



//module WBRegister(
//  input wire [63:0] aluResult_in,
//             [63:0] memData_in,
//             [4:0] rd_in,
//             wire MemtoReg_in, RegWrite_in,
//             clk, reset,
//  output reg [63:0] aluResult_out,
//         reg [63:0] memData_out,
//         reg [4:0] rd_out,
//         reg MemtoReg_out, reg RegWrite_out

//);
//  always @(posedge reset or posedge clk)
//  begin
//    if(reset)
//      begin
//        aluResult_out <= 64'b0;
//        memData_out <= 64'b0;
//        rd_out <= 5'b0;
//        MemtoReg_out <= 1'b0;
//        RegWrite_out <= 1'b0;
//      end
//    else
//      begin
//        aluResult_out <= aluResult_in;
//        memData_out <= memData_in;
//        rd_out <= rd_in;
//        MemtoReg_out <= MemtoReg_in;
//        RegWrite_out <= RegWrite_in;
//      end
//  end
//endmodule 