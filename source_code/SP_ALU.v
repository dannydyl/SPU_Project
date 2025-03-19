module SP_ALU(
  input [0:6] instr_id,
  input [0:127] ra_data,
  input [0:127] rb_data,
  input [0:127] rc_data, // rc port is also used for instructions that need rt data as an operand
  input [0:6] imme7,
  input [0:9] imme10,
  input [0:15] imme16,
  input [0:17] imme18,

  output reg [0:127] result
);

`include "opcode_package.vh"

wire [0:127] fa_result, fm_result, fma_result, fms_result, fnms_result, fs_result, mpy_result, mpya_result, 
              mpyh_result, mpyi_result, mpyu_result, mpyui_result;

always @(*) begin
  case (instr_id)
    `instr_ID_fa:    result = fa_result;
    `instr_ID_fm:    result = fm_result;
    `instr_ID_fma:   result = fma_result;
    `instr_ID_fms:   result = fms_result;
    `instr_ID_fnms:  result = fnms_result;
    `instr_ID_fs:    result = fs_result;
    `instr_ID_mpy:   result = mpy_result;
    `instr_ID_mpya:  result = mpya_result;
    `instr_ID_mpyh:  result = mpyh_result;
    `instr_ID_mpyi:  result = mpyi_result;
    `instr_ID_mpyu:  result = mpyu_result;
    `instr_ID_mpyui: result = mpyui_result;
    default : result = 128'h0;
  endcase
end



fa fa_inst (
  .ra(ra_data),
  .rb(rb_data),
  .result(fa_result)
);

fm fm_inst (
  .ra(ra_data),
  .rb(rb_data),
  .result(fm_result)
);

fma fma_inst (
  .ra(ra_data),
  .rb(rb_data),
  .rc(rc_data),
  .result(fma_result)
);

fms fms_inst (
  .ra(ra_data),
  .rb(rb_data),
  .rc(rc_data),
  .result(fms_result)
);

fnms fnms_inst (
  .ra(ra_data), 
  .rb(rb_data),
  .rc(rc_data),
  .result(fnms_result)
);

fs fs_inst (
  .ra(ra_data),
  .rb(rb_data),
  .result(fs_result)
);

mpy mpy_inst (
  .ra(ra_data),
  .rb(rb_data),
  .result(mpy_result)
);

mpya mpya_inst (
  .ra(ra_data),
  .rb(rb_data),
  .rc(rc_data),
  .result(mpya_result)
);

mpyh mpyh_inst (
  .ra(ra_data),
  .rb(rb_data),
  .result(mpyh_result)
);

mpyi mpyi_inst (
  .ra(ra_data),
  .imme10(imme10),
  .result(mpyi_result)
);

mpyu mpyu_inst (
  .ra(ra_data),
  .rb(rb_data),
  .result(mpyu_result)
);

mpyui mpyui_inst (
  .ra(ra_data),
  .imme10(imme10),
  .result(mpyui_result)
);



endmodule