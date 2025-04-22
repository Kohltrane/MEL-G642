`timescale 1ns/1ps
//combinatorial logic of the execute stage of five-stage pipelined RISC-V (RV32I) ISA implementation
module exec (rs1_d, rs2i_d, imm_d, op_a, op_l, op_s, sel_r, bra_c, res_d_op, res_bra, pc_v, off_v,  b_rs1_pc, res_brt_dma);
    input [31:0] rs1_d, rs2i_d, imm_d, pc_v, off_v;     //rs1 data, rs2 data or immediate data,
                                                                                            //immediate data, pc value, offset value
    input [3:0] op_a, op_s;     //operation arithmetic, operation shift
    input [2:0] op_l;     //operation logical
    input [1:0] sel_r;     //select result of arithmetic/logical/shift operation as the result of data operation 
    input [2:0] bra_c;     // branching condition
    input b_rs1_pc;     //base register rs1 or pc
    output [31:0] res_d_op, res_brt_dma;     //result of data operation, result of branch target or 
                                                                             //data memory address computation
    output res_bra;     //result of branch condition evaluation
    reg [31:0] res_d_op, res_brt_dma;
    reg res_bra;
    reg [32:0] res_d_op_a_33;     //result of arithmetic operation on data: 33 bits (including carry out)
    reg [31:0] res_d_op_a_32;     //result of  arithmetic operation on data: 32 bits(leaving carry out)
    reg [31:0] res_d_op_l_32;     //result of logical operation on data: 32 bits
    reg [31:0] res_d_op_s_32;     //result of shift operation on data: 32 bits
    // the arithmetic, logical and shift operations on data are performed independently in parallel
    // and the result of one of these operations is selected as the result of data operation-
    // depending upon the instruction
    always @(*)
    begin
        //ARITHMETIC OPERATIONS
        casex (op_a)     //data arithmetic function unit: handles operations ADD, SUB, LT, LTU
        4 'b0000 : 
            begin
            res_d_op_a_33 =  rs1_d +  rs2i_d;     //rs1 + rs2i  (33-bit result including carry out bit)
            res_d_op_a_32 =  res_d_op_a_33 [31:0];     //rs1 + rs2i (leaving out carry out bit)
            end
        4 'b1000 : 
            begin
            res_d_op_a_33 =  rs1_d -  rs2i_d;     //rs1 - rs2i  (33-bit result including carry out bit)
            res_d_op_a_32 =  res_d_op_a_33 [31:0];     //rs1 - rs2i (leaving out carry out bit)
            end
    
        4 'bx010 :
            begin 
            res_d_op_a_33 = rs1_d - rs2i_d;     //rs1 - rs2i  (for signed LT)
            res_d_op_a_32 = {{31{1'b0}}, res_d_op_a_33[32]};     //result for LT
            end
        4 'bx011:
            begin 
            res_d_op_a_33 =  rs1_d - rs2i_d;     //rs1 -rs2 (for unsigned LT)
            res_d_op_a_32 = {{31{1'b0}}, !res_d_op_a_33[32]};     //result for LTU
            end
        default: 
            begin
            res_d_op_a_33 =  rs1_d +  rs2i_d;     //rs1 + rs2 (33-bit result including carry out is default operation)
            res_d_op_a_32 = res_d_op_a_33 [31:0];     //default 32-bit result
            end
        endcase
        
        //LOGIC OPERATIONS
        casex (op_l)     // data logic function unit operation
        3 'b 100: res_d_op_l_32 = rs1_d ^ rs2i_d;     //XOR function
        3 'b 110: res_d_op_l_32 = rs1_d | rs2i_d;     //OR function
        3 'b 111: res_d_op_l_32 = rs1_d & rs2i_d;     //AND function
        default: res_d_op_l_32 = rs1_d ^ rs2i_d;     //XOR function is default
        endcase
        
        //SHIFT OPERATIONS
        casex (op_s)     //shift function  unit
        4 'b0001: res_d_op_s_32 = rs1_d << rs2i_d [4:0];     //shift left logical
        4 'b0101: res_d_op_s_32 = rs1_d >> rs2i_d [4:0];     //shift right logical
        4 'b1101: res_d_op_s_32 = rs1_d >>> rs2i_d [4:0];     //shift right arithmetic
        default: res_d_op_s_32 = rs1_d << rs2i_d [4:0];     //shift left logical is default operation
        endcase
        
        //BRANCH OPERATIONS
        casex (bra_c)     //branch condition evaluation: 1 / 0 (True/False)
        3 'b000 : res_bra = !(|res_d_op_a_33);
        3 'b001 : res_bra = |res_d_op_a_33;
        3 'b100 : res_bra = res_d_op_a_33[32];
        3 'b101 : res_bra = !res_d_op_a_33[32];
        3 'b110 : res_bra = !res_d_op_a_33[32];
        3 'b111 : res_bra = res_d_op_a_33[32];
        default: res_bra = 1 'b0;
        endcase
        
        //SELECTING BETWEEN OPERATION RESULTS - ARITHMETIC, LOGICAL, OR SHIFT
        casex (sel_r)
        2 'b00 : res_d_op = res_d_op_a_32;
        2 'b01 : res_d_op = res_d_op_l_32;
        2 'b10 : res_d_op = res_d_op_s_32;
        default: res_d_op = rs2i_d;
        endcase
        
        //BRANCH RESULTS
        casex (b_rs1_pc)
        1 'b0 : res_brt_dma =  rs1_d + off_v;
        1 'b1 : res_brt_dma = pc_v + off_v;
        endcase
    end 
endmodule
