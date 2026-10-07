`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2026 12:57:42 AM
// Design Name: 
// Module Name: reg_file
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
    
    
module reg_file(
    input clk,
    input rst,
    input write_enable,
    input [4:0] read_add1,
    input [4:0] read_add2,
    input [4:0] write_add,
    output [31:0] read_data1,
    output [31:0] read_data2,
    input [31:0] write_data
    );
    
    reg [31:0] regs [31:0];
    
    integer i; 
    initial begin
        for(i = 0; i<32; i = i +1)
            regs[i] = 32'b0;
        end
        
     always @(posedge clk) begin
        if(rst)begin
          for(i = 0; i<32; i = i +1)
            regs[i] <= 32'b0;
        end
        else if(write_enable && (write_add != 5'd0))
           regs[write_add] <= write_data;
     end
        
     assign read_data1 = (read_add1 == 5'd0) ? 32'b0 :
        (write_enable && (read_add1 == write_add)) ? write_data :
        regs[read_add1];
        
        assign read_data2 = (read_add2 == 5'd0) ? 32'b0 :
        (write_enable && (read_add2 == write_add)) ? write_data :
        regs[read_add2];
         
endmodule
