`timescale 1us / 1ns


module nslogic (ibin, sbin, dbin, cbin, nssel, nextst);
    input [4:0] ibin, sbin, dbin;	//ibin, sbin come from the decoder and dbin from the control word
    input cbin;	//cbin comes from execution unit : true if alu output = 0
    input [1:0] nssel;	//comes from the control word : next state selection control bits
    output [4:0] nextst;	//next state output : computed by next state logic
    reg [4:0] nextst;
    
    always @(*) begin
        case (nssel)
            2 'b00: nextst = dbin; 	//selects as next state the direct branch address supplied by the control word 
            2 'b01: nextst = ibin;	//selects as next state the ib output from the instruction decoder
            2 'b10: nextst = sbin;	//selects as next state the sb output from the instruction decoder
            2 'b11: nextst = {dbin[4:1], cbin};	//conditional branch on zero alu output : by bit stuffing
            default $display ("%m: undefined next state");
        endcase
    end
endmodule
