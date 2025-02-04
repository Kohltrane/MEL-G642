`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/04/2025 01:47:50 PM
// Design Name: 
// Module Name: shifter_tb
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


module shifter_tb();
    reg [31:0] a;
    reg [4:0] b;
    reg [1:0] c;
    wire [31:0] z_;
    
    shifter_32 dut(a,b,c,z_);
    
    initial begin
        $monitor("time=%t, Input a=%b, shift_amt=%b, shift_type=%b, Output = %b", $time, a,b,c,z_);
        #0 a=32'h0f00; b=4'b0001; c=2'b00;
        #5 a=32'h0f00; b=4'b0011; c=2'b00;
        #5 a=32'h0f00; b=4'b0010; c=2'b00;
        
        #5 a=32'h0f00; b=4'b0101; c=2'b01;
        #5 a=32'h0f00; b=4'b0110; c=2'b01;
        #5 a=32'h0f00; b=4'b1000; c=2'b01;
        
        #5 a=32'h0f00; b=4'b0101; c=2'b10;
        #5 a=32'h0f00; b=4'b0110; c=2'b10;
        #5 a=32'h0f00; b=4'b1000; c=2'b10;
        
        #5 a=32'h0f00; b=4'b0101; c=2'b11;
        #5 a=32'h0f00; b=4'b0110; c=2'b11;
        #5 a=32'h0f00; b=4'b1000; c=2'b11;
        $finish;        
    end
    
endmodule
