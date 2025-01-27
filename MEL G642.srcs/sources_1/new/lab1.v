`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.01.2025 14:23:19
// Design Name: 
// Module Name: lab1
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


module lab1(input signed[3:0] a,b,
    output signed[3:0] add, sub, mul, div, mod, and_, or_, not_, bitand, bitor, bitxor, shl, shr, ashl, ashr);
    reg signed[3:0] add, sub, mul, div, mod, and_, or_, not_, bitand, bitor, bitxor, shl, shr, ashl, ashr;

    always @(*) begin
        //arithmetic
        add=a+b;
        sub=a-b;
        mul=a*b;
        div=a*b;
        mod=a%b;

        //logical
        and_=a&&b;
        or_=a||b;
        not_= !a;

        //bitwise
        bitand=a&b;
        bitor=a|b;
        bitxor=a^b;

        //shift
        shl=a<<2;
        shr=a>>2;
        ashl=a<<<2;
        ashr=a>>>2;

        //relational operators will be directly tested in the testbench

    end

endmodule
