`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.01.2025 19:14:35
// Design Name: 
// Module Name: RCAu_16tb
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


`timescale 1ns/1ps

module RCAu_16_tb();
    // Parameters
    parameter SIZE = 16;
    
    // Test bench signals
    reg [SIZE-1:0] a, b;
    reg c_in;
    wire [SIZE-1:0] sum, c_out;
    
    // Instantiate the RCA
    RCAu_16 #(.SIZE(SIZE)) dut (
        .a(a),
        .b(b),
        .c_in(c_in),
        .sum(sum),
        .c_out(c_out)
    );
    
    // For checking results
    reg [SIZE:0] expected_sum;
    integer errors = 0;
    
    // Test vectors
    initial begin
        $display("Starting 16-bit RCA Testbench");
        
        // Test Case 1: Simple addition
        a = 16'h0001; b = 16'h0001; c_in = 0;
        #10;
        expected_sum = a + b + c_in;
        check_result(1);
        
        // Test Case 2: Larger numbers
        a = 16'h00FF; b = 16'h0001; c_in = 0;
        #10;
        expected_sum = a + b + c_in;
        check_result(2);
        
        // Test Case 3: With carry in
        a = 16'h00FF; b = 16'h00FF; c_in = 1;
        #10;
        expected_sum = a + b + c_in;
        check_result(3);
        
        // Test Case 4: Maximum value test
        a = 16'hFFFF; b = 16'h0001; c_in = 0;
        #10;
        expected_sum = a + b + c_in;
        check_result(4);
        
        // Test Case 5: Zero test
        a = 16'h0000; b = 16'h0000; c_in = 0;
        #10;
        expected_sum = a + b + c_in;
        check_result(5);
        
        // Test Case 6: Random test
        a = 16'h1234; b = 16'h5678; c_in = 1;
        #10;
        expected_sum = a + b + c_in;
        check_result(6);
        
        // Display final results
        $display("\nTestbench completed with %0d errors", errors);
        $finish;
    end
    
    // Task to check results
    task check_result;
        input integer test_num;
        begin
            if ({c_out[SIZE-1], sum} == expected_sum) begin
                $display("Test Case %0d PASSED: a=%h b=%h c_in=%b sum=%h c_out=%h",
                    test_num, a, b, c_in, sum, c_out);
            end else begin
                $display("Test Case %0d FAILED: a=%h b=%h c_in=%b",
                    test_num, a, b, c_in);
                $display("Expected: %h, Got: %h",
                    expected_sum, {c_out[SIZE-1], sum});
                errors = errors + 1;
            end
        end
    endtask
    
    // Optional: Generate VCD file for waveform viewing
    initial begin
        $dumpfile("rca_16_tb.vcd");
        $dumpvars(0, RCAu_16_tb);
    end
    
endmodule
