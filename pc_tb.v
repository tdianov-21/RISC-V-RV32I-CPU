`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2026 12:39:22 AM
// Design Name: 
// Module Name: pc_tb
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

module pc_tb;

    reg clk;
    reg rst;
    reg [31:0] pc_next;
    wire [31:0] pc_current;

    pc uut (
        .clk(clk),
        .rst(rst),
        .pc_next(pc_next),
        .pc_current(pc_current)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        rst = 1;
        pc_next = 32'd0;
        @(posedge clk);
        @(posedge clk);

        rst = 0;
        pc_next = pc_current + 4;
        @(posedge clk);
        pc_next = pc_current + 4;
        @(posedge clk);
        pc_next = pc_current + 4;
        @(posedge clk);

        $finish;
    end
endmodule
