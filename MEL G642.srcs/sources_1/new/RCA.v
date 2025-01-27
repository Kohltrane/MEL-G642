`timescale 1us/1ns

module signFA(input signed a, input signed b, input signed c_in, output signed sum, output signed c_out);
	reg sum,c_out;
	always @(a,b,c_in) begin
		sum = a^b^c_in;
		c_out = a&b | (c_in&(a^b));
	end
endmodule

module RCA_16 #(parameter SIZE=16) 
(input signed [SIZE-1:0] a,b , input signed c_in, output signed [SIZE-1:0] sum, c_out, output overflow);
	genvar g;
	signFA fa0(a[0],b[0],c_in,sum[0],c_out[0]);
	generate
		for(g=1; g<SIZE; g=g+1) begin
			signFA fa(a[g],b[g],c_out[g-1],sum[g],c_out[g]);
		end
	endgenerate

    reg overflow;
    always@(*) begin
        overflow=c_out[SIZE-1]^c_out[SIZE-2];
    end 

endmodule

module RCA_16 #(parameter SIZE=32) 
(input signed [SIZE-1:0] a,b , input signed c_in, output signed [SIZE-1:0] sum, c_out, output overflow);
	genvar g;
	signFA fa0(a[0],b[0],c_in,sum[0],c_out[0]);
	generate
		for(g=1; g<SIZE; g=g+1) begin
			signFA fa(a[g],b[g],c_out[g-1],sum[g],c_out[g]);
		end
	endgenerate

    reg overflow;
    always@(*) begin
        overflow=c_out[SIZE-1]^c_out[SIZE-2];
    end 

endmodule

module RCA_16 #(parameter SIZE=64) 
(input signed [SIZE-1:0] a,b , input signed c_in, output signed [SIZE-1:0] sum, c_out, output overflow);
	genvar g;
	signFA fa0(a[0],b[0],c_in,sum[0],c_out[0]);
	generate
		for(g=1; g<SIZE; g=g+1) begin
			signFA fa(a[g],b[g],c_out[g-1],sum[g],c_out[g]);
		end
	endgenerate

    reg overflow;
    always@(*) begin
        overflow=c_out[SIZE-1]^c_out[SIZE-2];
    end 

endmodule

