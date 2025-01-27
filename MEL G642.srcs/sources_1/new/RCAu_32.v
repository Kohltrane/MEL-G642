`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.01.2025 18:55:27
// Design Name: 
// Module Name: RCAu_32
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

module RCAu_32 #(parameter SIZE=32) 
(input [SIZE-1:0] a,b , input c_in, output [SIZE-1:0] sum, c_out);
	//reg [SIZE-1:0] c_out,sum;
	genvar g;
	FA fa0(a[0],b[0],c_in,sum[0],c_out[0]);
	
	generate
		for(g=1; g<SIZE; g=g+1) begin
			FA fa(a[g],b[g],c_out[g-1],sum[g],c_out[g]);
		end
	endgenerate

endmodule
