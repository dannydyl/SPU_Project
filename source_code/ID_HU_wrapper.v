module ID_HU_wrapper(
  input clk,
  input rst,
  input [0:31] instruction_in1,
  input [0:31] instruction_in2,

  
);

  // instruction format
localparam RRR = 3'b000;
localparam RR = 3'b001;
localparam RI7 = 3'b010;
localparam RI10 = 3'b011;
localparam RI16 = 3'b100;
localparam RI18 = 3'b101;

wire instr_rt_addr_even[0:6];

assign instr_rt_addr_even = (instr_format_even == RRR) ?  : instruction_even[25:31] ;

endmodule