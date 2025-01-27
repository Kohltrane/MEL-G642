`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.01.2025 14:58:57
// Design Name: 
// Module Name: lab1_tb
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


module lab1_tb;
    reg signed[3:0] a,b;
    wire signed[3:0] add, sub, mul, div, mod, and_, or_, not_, bitand, bitor, bitxor, shl, shr, ashl, ashr;
    integer i;
    lab1 testblock(a,b, add, sub, mul, div, mod, and_, or_, not_, bitand, bitor, bitxor, shl, shr, ashl, ashr);
    initial begin
        $monitor("a: %b, b: %b, @ time %0t \n \t add: %b, sub: %b, mul: %b, div: %b, mod: %b,\n \t and_: %b, or_: %b, not_: %b,\n \t bitand: %b, bitor: %bitor, bitxor: %b, shl: %b, shr: %b, ashl: %b, ashr:%b", a,b,$time,add, sub, mul, div, mod, and_, or_, not_, bitand, bitor, bitxor, shl, shr, ashl, ashr);
        for (i=0; i<4; i=i+1) begin
            case(i) 
                0: begin a=4'b1010; b=4'b1001; end
                1: begin a=4'b1110; b=4'b1111; end
                2: begin a=4'b1011; b=4'b1101; end
                3: begin a=4'b1011; b=4'b1011; end
                default: begin a=4'b0000; b=4'b0000; end
            endcase
            #10;
        end
        #10 $display("Result of a<b: %0d", a<b);
        #10 $display("Result of a>b: %0d", a>b);
        #10 $display("Result of a<=b: %0d", a<=b);
        #10 $display("Result of a>=b: %0d", a>=b);
        #10 $display("Result of a===b: %0d", a===b);
        #10 $display("Result of a!==b: %0d", a!==b);
        $finish;
    end
endmodule
