`timescale 1us/1ns
// Min Instruction Decoder Verilog Model (Combinational)
module instdecoder (instcode, ib, sb, op_s);
    input [15:0] instcode;
    output [4:0] ib, sb;
    output [2:0] op_s;
    reg [4:0] ib, sb;
    reg [2:0] op_s;
    
//001_100_xxxx_00_xxxx /010_100_xxxx_00_xxxx/011_100_xxxx_00_xxxx
//	ADD (R->R:AR)		SUB (R->R:AR)		AND (R->R:AR)
// ADD/SUB/AND (R->R: AR): ib = oprr1(17); sb = xx(00); op_s = ire [15:13]

//001_100_xxxx_01_xxxx /010_100_xxxx_01_xxxx/011_100_xxxx_01_xxxx
//	ADD (R->M:AI)		SUB (R->M:AI)		AND (R->M:AI)
// ADD/SUB/AND (R->M: AI): ib = adrm1(05); sb = oprm1(12); op_s = ire[15:13]

//001_100_xxxx_10_xxxx /010_100_xxxx_10_xxxx/011_100_xxxx_10_xxxx
//	ADD (R->M:AB)		SUB (R->M:AB)		AND (R->M:AB)
// ADD/SUB/AND (R->M: AB): ib = abdm1(01); sb = oprm1(12); op_s = ire[15:13]

//000_001_xxxx_00_xxxx
//	LOAD (R<-R: AR)
//LOAD (R<-R: AR): ib = ldrr1(15); sb = xx(00); op_s = ire[15:13]

//000_001_xxxx_01_xxxx
//	LOAD (R<-M: AI)
//LOAD (R<-M: AI): ib = adrm1(05); sb = ldrm1(10); op_s = ire[15:13]

//000_001_xxxx_10_xxxx
//	LOAD (R<-M: AB)
//LOAD (R<-M): AB): ib = abdm1(01); sb = ldrm1(10); op_s = ire[15:13]

//000_010_xxxx_00_xxxx
//	STORE (R->R: AR)
//STORE (R->R: AR): ib = strr1(16); sb = xx(00); op_s = ire[15:13]
//000_010_xxxx_01_xxxx
//	STORE (R->M: AI)
//STORE (R->M: AI): ib = adrm1(05); sb = strm1(11); op_s = ire[15:13]

//000_010_xxxx_10_xxxx
//	STORE (R->M: AB)
//STORE (R->M: AB): ib = abdm1(01); sb = strm1(11); op_s = ire[15:13]

//000_101_xxxx_xx_xxxx
//	BZ
//BZ: ib = brzz1(09); sb = xx(00); op_s = ire{15:13]

//000_110_xxxx_xx_xxxx
//	POP
//POP: ib = popr1(19); sb= xx(00); op_s = ire[15:13]

//001_110_xxxx_xx_xxxx
//	PUSH
//PUSH: ib = push1(21); sb = xx(00); op_s = ire[15:13]

//000_011_xxxx_01_xxxx
//	TEST (M: AI)
//TEST (M: AI): ib = adrm1(05); sb = test1(14); op_s = ire[15:13]

//000_011_xxxx_10_xxxx
//	TEST (M: AB)
//TEST (M: AB): ib = abdm1(01); sb = test1(14); op_s = ire[15:13]




// ADD/SUB/AND (R->R: AR): ib = oprr1(17); sb = xx(00); op_s = ire [15:13]
// ADD/SUB/AND (R->M: AI): ib = adrm1(05); sb = oprm1(12); op_s = ire[15:13]
// ADD/SUB/AND (R->M: AB): ib = abdm1(01); sb = oprm1(12); op_s = ire[15:13]
//LOAD (R<-R: AR): ib = ldrr1(15); sb = xx(00); op_s = ire[15:13]
//LOAD (R<-M: AI): ib = adrm1(05); sb = ldrm1(10); op_s = ire[15:13]
//LOAD (R<-M): AB): ib = abdm1(01); sb = ldrm1(10); op_s = ire[15:13]
//STORE (R->R: AR): ib = strr1(16); sb = xx(00); op_s = ire[15:13]
//STORE (R->M: AI): ib = adrm1(05); sb = strm1(11); op_s = ire[15:13]
//STORE (R->M: AB): ib = abdm1(01); sb = strm1(11); op_s = ire[15:13]
//BZ: ib = brzz1(09); sb = xx(00); op_s = ire{15:13]
//POP: ib = popr1(19); sb= xx(00); op_s = ire[15:13]
//PUSH: ib = push1(21); sb = xx(00); op_s = ire[15:13]
//TEST (M: AI): ib = adrm1(05); sb = test1(14); op_s = ire[15:13]
//TEST (M: AB): ib = abdm1(01); sb = test1(14); op_s = ire[15:13]
    always @(*) begin
        casex (instcode)
            16'b001100xxxx00xxxx, 16'b010100xxxx00xxxx, 16'b011100xxxx00xxxx: 
                begin  ib = 17; sb = 0; op_s = instcode [15:13];  end
            16'b001100xxxx01xxxx, 16'b010100xxxx01xxxx, 16'b011100xxxx01xxxx:
                begin  ib = 5; sb = 12; op_s = instcode [15:13]; end
            16'b001100xxxx10xxxx, 16'b010100xxxx10xxxx, 16'b011100xxxx10xxxx:
                begin ib = 1; sb = 12; op_s = instcode[15:13]; end
            16'b000001xxxx00xxxx:
                begin ib = 15; sb = 0; op_s = instcode[15:13]; end
            16'b000001xxxx01xxxx:
                begin ib = 5; sb = 10; op_s = instcode[15:13]; end
            16'b000001xxxx10xxxx:
                begin ib = 1; sb = 10; op_s = instcode[15:13]; end
            16'b000010xxxx00xxxx:
                begin ib = 16; sb = 0; op_s = instcode[15:13]; end
            16'b000010xxxx01xxxx:
                begin ib = 5; sb = 11; op_s = instcode[15:13]; end
            16'b000010xxxx10xxxx:
                begin ib = 1; sb = 11; op_s = instcode[15:13]; end
            16'b000101xxxxxxxxxx:
                begin ib = 9; sb = 0; op_s = instcode[15:13]; end
            16'b000110xxxxxxxxxx:
                begin ib = 19; sb = 0; op_s = instcode[15:13]; end
            16'b001110xxxxxxxxxx:
                begin ib = 21; sb = 0; op_s = instcode[15:13]; end
            16'b000011xxxx01xxxx:
                begin ib = 5; sb = 14; op_s = instcode[15:13]; end
            16'b000011xxxx10xxxx:
                begin ib = 1; sb = 14; op_s = instcode[15:13]; end
            default:
                begin 
                ib = 31; sb = 31; op_s = 7; 
                $display ( "%m : at time  %d  Illegal Instruction Code = %b", $time, instcode);
                end
        endcase
    end
endmodule