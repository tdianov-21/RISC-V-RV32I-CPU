`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/07/2026 01:22:10 PM
// Design Name: 
// Module Name: reg_tb
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

module reg_file_tb;

    // Inputs to the DUT (driven by the testbench)
    reg         clk;
    reg         rst;
    reg         write_enable;
    reg  [4:0]  read_add1;
    reg  [4:0]  read_add2;
    reg  [4:0]  write_add;
    reg  [31:0] write_data;

    // Outputs from the DUT (observed by the testbench)
    wire [31:0] read_data1;
    wire [31:0] read_data2;

    // Device under test
    reg_file dut (
        .clk(clk),
        .rst(rst),
        .write_enable(write_enable),
        .read_add1(read_add1),
        .read_add2(read_add2),
        .write_add(write_add),
        .read_data1(read_data1),
        .read_data2(read_data2),
        .write_data(write_data)
    );

    // Clock: 10 ns period
    initial clk = 0;
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        // Initialize every input at time 0
        rst          = 0;
        write_enable = 0;
        read_add1    = 5'd0;
        read_add2    = 5'd0;
        write_add    = 5'd0;
        write_data   = 32'd0;
        #12;

        // TEST 1: normal write, then read back on both ports b 12ns
        // TODO
           write_add = 5'd5;
           write_data = 32'd99;
           write_enable = 1;
           
           @(posedge clk);
           #1;
           
           write_enable = 0;
           read_add1 = 5'd5;
           read_add2 = 5'd5;
           #1;
           
           if(read_data1 !== 32'd99)
            $display("TEST 1 FAILED: read_data1 = %0d, expected 99", read_data1);
           if(read_data2 !== 32'd99)
            $display("TEST 1 FAILED: read_data2 = %0d, expected 99", read_data2);
           if(read_data1 === 32'd99 && read_data2 === 32'd99)
            $display("TEST 1 PASS");
        // TEST 2: write to x0, confirm it still reads 0 25 ns
        // TODO
           write_add = 5'd0;
           write_data = 32'd99;
           write_enable = 1;
           
           @(posedge clk);
           #1;
           
           write_enable = 0;
           read_add1 = 5'd0;
           read_add2 = 5'd0;
           #1;
           
           if(read_data1 !== 32'd0)
            $display("TEST 2 FAILED: read_data1 = %0d, expected 0", read_data1);
           if(read_data2 !== 32'd0)
            $display("TEST 2 FAILED: read_data2 = %0d, expected 0", read_data2);
           if(read_data1 === 32'd0 && read_data2 === 32'd0)
            $display("TEST 2 PASS");
        // TEST 3: bypass, same-cycle write and read (write_enable = 1) 
        // TODO: set inputs, check read_data1 BEFORE the next posedge
           write_add = 5'd5;
           write_data = 32'd55;
           write_enable = 1;
           read_add1 = 5'd5;
           read_add2 = 5'd5;
           #1;
           
           if(read_data1 !== 32'd55)
            $display("TEST 3 FAILED: read_data1 = %0d, expected 55", read_data1);
           if(read_data2 !== 32'd55)
            $display("TEST 3 FAILED: read_data2 = %0d, expected 55", read_data2);
           if(read_data1 === 32'd55 && read_data2 === 32'd55)
            $display("TEST 3 PASS");
        // TEST 4: no bypass when write_enable = 0
        // TODO
            write_add = 5'd5;
           write_data = 32'd66;
           write_enable = 0;
           read_add1 = 5'd5;
           read_add2 = 5'd5;
 
           #1;
           
           if(read_data1 !== 32'd99)
            $display("TEST 4 FAILED: read_data1 = %0d, expected 99", read_data1);
           if(read_data2 !== 32'd99)
            $display("TEST 4 FAILED: read_data2 = %0d, expected 99", read_data2);
           if(read_data1 === 32'd99 && read_data2 === 32'd99)
            $display("TEST 4 PASS");
        // TEST 5: reset clears registers
        // TODO: write values, pulse rst for one clock edge, read them back
           rst = 1'b1;
           write_add = 5'd5;
           write_data = 32'd66;
           write_enable = 0;
           read_add1 = 5'd5;
           read_add2 = 5'd5;
           @(posedge clk);
           #1;
         
           if(read_data1 !== 32'd0)
            $display("TEST 5 FAILED: read_data1 = %0d, expected 0", read_data1);
           if(read_data2 !== 32'd0)
            $display("TEST 5 FAILED: read_data2 = %0d, expected 0", read_data2);
           if(read_data1 === 32'd0 && read_data2 === 32'd0)
            $display("TEST 5 PASS");
            rst = 1'b0;
        #20;
        $finish;
    end

endmodule