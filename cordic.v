`timescale 1ns / 1ps
//TODO:
    //Approximating alpha ----> DONE
    //Approximating arc_tan
module cordic(
    input clk, reset, //synchronous
    input signed [15:0] argument, //argument
    //input amp_factor,
    output signed [15:0] sine_val,cos_val,
    output done
    );
    reg done;
    reg signed [15:0] sine_val,cos_val;
    reg signed [15:0] alpha; //approximation of arg, 2.14 representation
    reg signed [15:0] arc_tan, arg; //2.14 representation
    reg signed [15:0] x,y;
    reg [5:0] i;
    
    function signed [15:0] cordic_arctan;
        input [5:0] i;
        case(i)
            6'd0: cordic_arctan=16'b0011001001000100;
            6'd1: cordic_arctan=16'b0011101101011000;
            6'd2: cordic_arctan=16'b0011111010111000;
            6'd3: cordic_arctan=16'b0011111110101000;
            6'd4: cordic_arctan=16'b0011111111110000;
            6'd5: cordic_arctan=16'b0010000000000000;
            6'd6: cordic_arctan=16'b0010000000000000;
            6'd7: cordic_arctan=16'b0010000000000000;
            6'd8: cordic_arctan=16'b0010000000000000;
            6'd9: cordic_arctan=16'b0010000000000000;
            6'd10: cordic_arctan=16'b0010000000000000;
            6'd11: cordic_arctan=16'b0010000000000000;
            6'd12: cordic_arctan=16'b0010000000000000;
            6'd13: cordic_arctan=16'b0010000000000000;
            6'd14: cordic_arctan=16'b0010000000000000;
            6'd15: cordic_arctan=16'b0000000000000000;
            default: cordic_arctan=0;
        endcase
    endfunction

    always @(negedge clk) begin
        if (reset) begin
            x<=15'd10;
            y<=0;
            arg<=argument;
            i<=0;
            done<=0;
        end
        else if (i<30) begin
            if (arg>=alpha) begin
                x<=x-(y>>>i);
                y<=y+(x>>>i);
                arc_tan<=cordic_arctan(i);
                alpha<=alpha - arc_tan;
            end
            else begin
                x<=x+(y>>>i);
                y<=y-(x>>>i);
                arc_tan<=cordic_arctan(i);
                alpha<=alpha - arc_tan;
            end
            i<=i+1;
        end
        
        else begin
            sine_val<=y;
            cos_val<=x;
            done<=1;
        end
    end
    
endmodule
