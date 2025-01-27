`timescale 1us/1ns

module FA(input a, input b, input c_in, output sum, output c_out);
	reg sum,c_out;
	always @(a,b,c_in) begin
		sum = a^b^c_in;
		c_out = a&b | (c_in&(a^b));
	end
endmodule

module RCAu_16 #(parameter SIZE=16) 
(input [SIZE-1:0] a,b , input c_in, output [SIZE-1:0] sum, c_out, output overflow);
	//reg [SIZE-1:0] c_out,sum;
	genvar g;
	FA fa0(a[0],b[0],c_in,sum[0],c_out[0]);
	
	generate
		for(g=1; g<SIZE; g=g+1) begin
			FA fa(a[g],b[g],c_out[g-1],sum[g],c_out[g]);
		end
	endgenerate

	reg overflow;
    always@(*) begin
        overflow=c_out[SIZE-1]^c_out[SIZE-2];
    end  

endmodule



