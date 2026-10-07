`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/07/2026 02:04:08 PM
// Design Name: 
// Module Name: ALU_file
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


module ALU_file(
    input [31:0] a,
    input [31:0] b,
    input [3:0] alu_op,
    output reg [31:0] result,
    output zero_flg
    );
    always @(*) begin
        case (alu_op)
            4'b0: result = a + b;
            4'b1000: result = a - b;
            4'b0111: result = a & b;
            4'b0110: result = a | b;
            4'b0100: result = a ^ b;
            4'b0001: result = a << b[4:0];
            4'b0101: result = a >> b[4:0];
            4'b1101: result = $signed(a) >>> b[4:0];
            4'b0010: result = $signed(a) < $signed(b);
            4'b0011: result = a < b;
            default: result = 32'b0;
            endcase
   end
   assign zero_flg = (result == 32'b0);
endmodule
