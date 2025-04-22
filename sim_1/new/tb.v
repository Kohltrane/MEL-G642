`timescale 1ns / 1ps

module tb;
    reg [31:0] rs1_d, rs2i_d, imm_d, pc_v, off_v;     //rs1 data, rs2 data or immediate data,
                                                                                            //immediate data, pc value, offset value
    reg [3:0] op_a, op_s;     //operation arithmetic, operation shift
    reg [2:0] op_l;     //operation logical
    reg [1:0] sel_r;     //select result of arithmetic/logical/shift operation as the result of data operation 
    reg [2:0] bra_c;     // branching condition
    reg b_rs1_pc;     //base register rs1 or pc
    
    wire [31:0] res_d_op, res_brt_dma;     //result of data operation, result of branch target or                                                                      //data memory address computation
    wire res_bra;     //result of branch condition evaluation
    
    exec dut(.rs1_d(rs1_d), 
             .rs2i_d(rs2i_d),
             .imm_d(imm_d), 
             .pc_v(pc_v), 
             .off_v(off_v),
             .opa_a(op_a),
             .op_s(op_s),
             .op_l(op_l),
             .sel_r(sel_r),
             .bra_c(bra_c),
             .b_rs1_pc(b_rs1_pc),
             .res_d_op(res_d_op),
             .res_brt_dma(res_brt_dma),
             .res_bra(res_bra));
             
     initial begin
        //add operation
        #0 rs1_d = 31'h00ff; rs2i_d = 31'h1001; op_a=4'b0000; sel_r=2'b00;
        #10 rs1_d = 31'h00ff; rs2i_d = 31'h1001; op_a=4'b1000; sel_r=2'b00;
        #10 rs1_d = 31'h00ff; rs2i_d = 31'h1001; op_a=4'b0000; sel_r=2'b00;

     end
endmodule
