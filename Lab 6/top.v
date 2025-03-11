`timescale 1us/1ns

// Top-level module. Instantiates and wires the four lower-level module
// convention: wires that connect module instances have their names beginning with character "w"
module main; 
    reg sysclock;
    wire [24:0] wcontword;
    wire [17:0] weucntl;
    wire [4:0] wnextst, wib, wsb, wdb;
    wire [15:0] wifd;
    wire [2:0] wop_s;
    wire [1:0] wnssel;
    wire wccz;

    assign wdb = wcontword [4:0];
    assign wnssel = wcontword [6:5];
    assign weucntl = wcontword [24:7];
// 1. Instantiate module controlstore : provides positive edge registered controlword for a given state
    controlstore controlgen (.address (wnextst), .clock (sysclock), .controlword (wcontword));
// 2. Instantiate module mineu : min execution unit extended to include synchronous main memory 
    mineu execunit (.eucntl (weucntl), .opcntl (wop_s), .clock (sysclock), .cc({3'b000,{wccz}}), .ifd (wifd));	
/* 3. Instantiate module  instdecoder : instruction decoder provides ib, sb and op-s for an instruction */
    instdecoder decoder (.instcode (wifd), .ib (wib), .sb (wsb), .op_s (wop_s));
// 4. Instantiate  module nslogic : the logic to generate next state (next control ROM address)
    nslogic nextstgen (.ibin (wib), .sbin (wsb), .dbin (wdb), .cbin (wccz), .nssel (wnssel), .nextst (wnextst));

// system clock generator
    initial sysclock = 0;
    always begin
        # 50 sysclock = !sysclock;
        if ($time >= 5000) $finish;
    end
endmodule
