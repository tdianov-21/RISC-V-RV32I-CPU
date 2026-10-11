`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2026 09:06:41 PM
// Design Name: 
// Module Name: imm
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


module imm(
    input [31:0] instru,
    output reg [31:0] imm
    );
    
    always @(*) begin
        case(instru[6:0])
            7'b0010011, 7'b0000011, 7'b1100111: imm = {{20{instru[31]}}, (instru[31:20]) }; //I
            7'b0100011: imm = {{20{instru[31]}}, instru[31:25] , instru[11:7]}; //S
            7'b1100011: imm = { {19{instru[31]}}, instru[31] , instru[7] , instru[30:25] , instru[11:8] , 1'b0 }; // B
            7'b0110111, 7'b0010111: imm =  {instru[31:12] , 12'b0}; // U
            7'b1101111: imm = {{11{instru[31]}}, instru[31], instru[19:12], instru[20], instru[30:21], 1'b0}; // J
            default: imm = 32'b0;
        endcase
     end
endmodule
