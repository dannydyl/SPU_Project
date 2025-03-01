module RF_FU_wrapper(
  input clk,
  input rst,
  input reg_write_en_1,
  input reg_write_en_2,

  input [0:31] instruction_even,
  input [0:31] instruction_odd,
  input [0:2] unit_id_even,
  input [0:2] unit_id_odd,
  input [0:6] instr_id_even,
  input [0:6] instr_id_odd,

  input [0:127] ra_even,
  input [0:127] rb_even,
  input [0:127] rc_even,

  input [0:127] ra_odd,
  input [0:127] rb_odd,
  input [0:127] rc_odd,



);

endmodule