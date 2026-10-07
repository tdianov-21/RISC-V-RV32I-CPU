`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/07/2026 02:43:19 PM
// Design Name: 
// Module Name: ALU_TB
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


`timescale 1ns / 1ps

module ALU_tb;

    reg  [31:0] a;
    reg  [31:0] b;
    reg  [3:0]  alu_op;
    wire [31:0] result;
    wire        zero_flg;
    integer testrack = 0;
    ALU_file dut (
        .a(a), .b(b), .alu_op(alu_op),
        .result(result), .zero_flg(zero_flg)
    );

    initial begin
        a = 0; b = 0; alu_op = 4'b0000;
        #5;

        // TEST 1: ADD wraparound
        //   a = FFFFFFFF, b = 1, op = 0000 -> result 0, zero_flg 1
         a = 32'hFFFFFFFF;
         b = 32'b1;
         alu_op = 4'b0;
         #1;
         if(result !== 32'b0)
            $display("TEST 1 FAILED: result = %0d, expected 0", result);
         if(zero_flg !== 1'b1)
            $display("TEST 1 FAILED: zero_flg = %0d, expected 1", zero_flg);
         if(result === 32'b0 && zero_flg === 1'b1)
            $display("TEST 1 PASSED");
        // TEST 2: ADD normal
        //   a = 5, b = 7, op = 0000 -> result 12, zero_flg 0
         a = 32'd5;
         b = 32'd7;
         alu_op = 4'b0;
         #1;
         if(result !== 32'd12)
            $display("TEST 2 FAILED: result = %0d, expected 12", result);
         if(zero_flg !== 1'b0)
            $display("TEST 2 FAILED: zero_flg = %0d, expected 0", zero_flg);
         if(result === 32'd12 && zero_flg === 1'b0)
            $display("TEST 2 PASSED");
        // TEST 3: SUB
        //   a = 10, b = 3, op = 1000 -> result 7
        //   a = 3,  b = 10, op = 1000 -> result FFFFFFF9 (-7)
         a = 32'd10;
         b = 32'd3;
         alu_op = 4'b1000;
         #1;
         if(result !== 32'd7)
            $display("TEST 3a FAILED: result = %0d, expected 7", result);
         if(zero_flg !== 1'b0)
            $display("TEST 3a FAILED: zero_flg = %0d, expected 0", zero_flg);
         if(result === 32'd7 && zero_flg === 1'b0)
            $display("TEST 3a PASSED");
            
         a = 32'd3;
         b = 32'd10;
         alu_op = 4'b1000;
         #1;
         if(result !== -32'd7)
            $display("TEST 3b FAILED: result = %0d, expected -7", result);
         if(zero_flg !== 1'b0)
            $display("TEST 3b FAILED: zero_flg = %0d, expected 0", zero_flg);
         if(result === -32'd7 && zero_flg === 1'b0)
            $display("TEST 3b PASSED");
        // TEST 4: AND / OR / XOR
        //   a = F0F0F0F0, b = 0FF00FF0
        //   AND (0111) -> 00F000F0
        //   OR  (0110) -> FFF0FFF0
        //   XOR (0100) -> FF00FF00
         
         a = 32'hF0F0F0F0;
         b = 32'h0FF00FF0;
         alu_op = 4'b0111;
         #1;
         if(result !== 32'h00F000F0)begin
            $display("TEST 4 FAILED: result = %0h, expected 00F000F0", result);
            testrack = testrack + 1;
            end
         alu_op = 4'b0110;
         #1;
         if(result !== 32'hFFF0FFF0)begin 
            $display("TEST 4 FAILED: result = %0h, expected FFF0FFF0", result);
            testrack = testrack + 1;
            end
         alu_op = 4'b0100;
         #1;
         if(result !== 32'hFF00FF00)begin
            $display("TEST 4 FAILED: result = %0h, expected FF00FF00", result);
          testrack = testrack + 1;
          end
          if(testrack === 0)
            $display("TEST 4 PASSED");
            testrack = 0;
        // TEST 5: SLL
        //   a = 1, b = 4, op = 0001 -> result 16
        //   a = 1, b = 33, op = 0001 -> result 2  (only b[4:0] counts)
         a = 32'd1;
         b = 32'd4;
         alu_op = 4'b0001;
         #1;
         if(result !== 32'd16) begin
            $display("TEST 5a FAILED: result = %0d, expected 16", result);
            testrack = testrack + 1;
          end
         a = 32'd1;
         b = 32'd33;
         #1;
         if(result !== 32'd2) begin
            $display("TEST 5b FAILED: result = %0d, expected 2", result);
            testrack = testrack + 1;
          end
          if(testrack === 0)
            $display("TEST 5 PASSED");
          testrack = 0;
        // TEST 6: SRL vs SRA
        //   a = F0000000, b = 4
        //   SRL (0101) -> 0F000000
        //   SRA (1101) -> FF000000       
         a = 32'hF0000000;
         b = 32'd4;
         alu_op = 4'b0101;
         #1;
         if(result !== 32'h0F000000) begin
            $display("TEST 6a FAILED: result = %0h, expected 0F000000", result);
            testrack = testrack + 1;
          end
         alu_op = 4'b1101;
         #1;
         if(result !== 32'hFF000000) begin
            $display("TEST 6b FAILED: result = %0h, expected FF000000", result);
            testrack = testrack + 1;
          end
          if(testrack === 0)
            $display("TEST 6 PASSED");
          testrack = 0;
        // TEST 7: SLT vs SLTU
        //   a = FFFFFFFF, b = 1
        //   SLT  (0010) -> 1
        //   SLTU (0011) -> 0
        //   then swap them: a = 1, b = FFFFFFFF
        //   SLT  -> 0
        //   SLTU -> 1
         a = 32'hFFFFFFFF;
         b = 32'd1;
         alu_op = 4'b0010;
         #1;
         if(result !== 32'd1) begin
            $display("TEST 7a FAILED: result = %0d, expected 1", result);
            testrack = testrack + 1;
         end
         alu_op = 4'b0011;
         #1;
         if(result !== 32'd0) begin
            $display("TEST 7b FAILED: result = %0d, expected 0", result);
            testrack = testrack + 1;
          end
          
         a = 32'd1;
         b = 32'hFFFFFFFF;
         alu_op = 4'b0010;
         #1;
         if(result !== 32'd0) begin
            $display("TEST 7c FAILED: result = %0d, expected 0", result);
            testrack = testrack + 1;
         end
         alu_op = 4'b0011;
         #1;
         if(result !== 32'd1) begin
            $display("TEST 7d FAILED: result = %0d, expected 1", result);
            testrack = testrack + 1;
          end
          if(testrack === 0)
            $display("TEST 7 PASSED");
          testrack = 0;
        // TEST 8: default
        //   op = 1111 -> result 0, zero_flg 1
         alu_op = 4'b1111;
         #1;
         if(result !== 32'd0)
            $display("TEST 8 FAILED: result = %0d, expected 0", result);
         if(zero_flg !== 1'b1)
            $display("TEST 8 FAILED: zero_flg = %0d, expected 1", zero_flg);
         if(result === 32'b0 && zero_flg === 1'b1)
            $display("TEST 8 PASSED");  
        #10;
        $finish;
    end

endmodule