`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2026 12:34:07 AM
// Design Name: 
// Module Name: pc
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
module pc(
    input clk,
    input rst,
    input [31:0] pc_next,
    output reg [31:0] pc_current
    );
    
    always @(posedge clk) begin
    if(rst)
        pc_current <= 32'b0;
    else
        pc_current <= pc_next;
    end
endmodule
