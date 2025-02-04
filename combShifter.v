`timescale 1ns / 1ps
/* Design of a 32-bit combinational shifter that can do logical shift (left/right) and arithmetic shift (left/right) by any amount between 0 to 31 bits based on its control signals.
Shifter has a 32-bit operand as input on which the shift is to be applied
A five bit unsigned integer that specifies the amount of shift
And a 2-bit control that specifies the type of shift operation (left/right; logical/arithmetic)
It has one 32-bit output that is the result of the shift operation */
/* The shifter has five stages each of which performs a shift (of the type specified by 2-bit shift-type  control) by an amount represented by the numerical value of the bit that controls the shift amount of the stage: for example if the msb of 5-bit shift amount is 1/0, then the first stage shifts the input by 16/0  bits (the shift is of the type specified by the 2-bit shift type control) */

module shifter_32 (a, b, c, z_);
    input [31 : 0] a;		//operand
    input [4 : 0] b;		//shift amount
    input [1 : 0] c;		//shift type
    output [31 : 0] z_;
    reg [31 : 0]  z4, z3, z2, z1;	//intermediate results  of cascaded shift stages 
    reg [31:0] z_;
    reg [1 : 0] sel4, sel3, sel2, sel1, sel0;	//mux controls for the 5-stages of muxes
    always @ (a, b, c)
    // setting up control signals (sel4, sel3, sel2, sel1, sel0) for the five stages of 4:1 muxes 
//based on the shift type and the shift amount to be performed by each stage

//c[1]=left/right   c[0]=logic/arith
    begin
        casex ({c, b[4]})
            3 'bxx0 : sel4 = 2 'b11;
            3 'b0x1 : sel4 = 2 'b10;
            3 'b111 : sel4 = 2 'b01;
            3 'b101 : sel4 = 2 'b00;
        endcase 
        casex ({c, b[3]})
            3 'bxx0 : sel3 = 2 'b11;
            3 'b0x1 : sel3 = 2 'b10;
            3 'b111 : sel3 = 2 'b01;
            3 'b101 : sel3 = 2 'b00;
        endcase
            casex ({c, b[2]})
            3 'bxx0 : sel2 = 2 'b11;
            3 'b0x1 : sel2 = 2 'b10;
            3 'b111 : sel2 = 2 'b01;
            3 'b101 : sel2 = 2 'b00;
        endcase 
        casex ({c, b[1]})
            3 'bxx0 : sel1 = 2 'b11;
            3 'b0x1 : sel1 = 2 'b10;
            3 'b111 : sel1 = 2 'b01;
            3 'b101 : sel1 = 2 'b00;
        endcase
        casex ({c, b[0]})
            3 'bxx0 : sel0 = 2 'b11;
            3 'b0x1 : sel0 = 2 'b10;
            3 'b111 : sel0 = 2 'b01;
            3 'b101 : sel0 = 2 'b00;
        endcase
    //shift stage 4: performs 16/0-bit shift of the specified type on the input
        case (sel4)
            2 'b11 : z4 = a; 
            2 'b10 : z4 = {a[15 :0],{16{1'b0}} };
            2 'b01 : z4 = {{16{a[31]}}, a[31 : 16]};
            2 'b00 : z4 = {{16{1 'b0}}, a[31 : 16]};
        endcase
    //shift stage 3: performs 8/0-bit shift of the specified type on its input
        case (sel3)
            2 'b11 : z3 = z4; 
            2 'b10 : z3 = {z4[23 : 0], {8{1 'b0}}};
            2 'b01 : z3 = {{8{z4[31]}}, z4[31 : 8]};
            2 'b00 : z3 = {{8{1 'b0}}, z4[31 : 8]};
        endcase
    
        case (sel2)
            2 'b11 : z2 = z3; 
            2 'b10 : z2 = {z3[27 : 0], {4{1 'b0}}};
            2 'b01 : z2 = {{4{z3[31]}}, z3[31 : 4]};
            2 'b00 : z3 = {{4{1 'b0}}, z3[31 : 4]};
        endcase
        
        case (sel1)
            2 'b11 : z1 = z2; 
            2 'b10 : z1 = {z2[29 : 0], {2{1 'b0}}};
            2 'b01 : z1 = {{2{z2[31]}}, z2[31 : 2]};
            2 'b00 : z1 = {{2{1 'b0}}, z2[31 : 2]};
        endcase
    
        case (sel0)
            2 'b11 : z_ = z1; 
            2 'b10 : z_ = {z1[30 : 0], 1 'b0};
            2 'b01 : z_ = {{z1[31]}, z1[31 : 1]};
            2 'b00 : z_ = {1 'b0, z1[31 : 1]};
        endcase
    end
endmodule
