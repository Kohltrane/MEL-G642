`timescale 1ns / 1ps

module room_control(
    input Tgt27,
    input Tgt23,
    input Tlt23,
    input Tlt22,
    input Tgt18,
    input Tlt15,
    output reg fan,
    output reg heater,
    output reg AC
    );
    
    wire in = {Tgt27,Tgt23,Tlt23,Tlt22,Tgt18,Tlt15};
    always @(*) begin
        case(in)
            6'b110010:begin fan=1; AC=1; heater=0; end
            6'b010010:begin fan=1; AC=AC; heater=0; end
            6'b001010:begin fan=fan; AC=0; heater=0; end
            6'b001110:begin end;
            6'b001100:begin end;
            6'b001101:begin end;
        endcase 
    end
endmodule
