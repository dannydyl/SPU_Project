module BRANCH_ALU(
  input [0:6] instr_id,
  input [0:15] imme16,
  input [0:127] rc_data, // used for rt

  input [0:9] in_PC,

  output reg [0:9] PC_result,
  output reg [0:127] rt_result
);

`include "opcode_package.vh"

wire [0:9] br_result, bra_result, brasl_result, brhnz_result, brhz_result, brnz_result, brsl_result, brz_result;
wire [0:127] rt_result_temp;

always @(*) begin
  case (instr_id)
    `instr_ID_br:    PC_result = br_result;
    `instr_ID_bra:   PC_result = bra_result;
    `instr_ID_brasl: PC_result = brasl_result;
    `instr_ID_brhnz: PC_result = brhnz_result;
    `instr_ID_brhz:  PC_result = brhz_result;
    `instr_ID_brnz:  PC_result = brnz_result;
    `instr_ID_brsl:  PC_result = brsl_result;
    `instr_ID_brz:   PC_result = brz_result;
    default : PC_result = 10'h0;
  endcase
  rt_result = rt_result_temp;
end

br br_inst (
  .in_PC(in_PC),
  .imme16(imme16),
  .PC_result(br_result)
);

bra bra_inst (
  .imme16(imme16),
  .PC_result(bra_result)
);

brasl brasl_inst (
  .in_PC(in_PC),
  .imme16(imme16),
  .PC_result(brasl_result),
  .rt_result(rt_result_temp)
);

brhnz brhnz_inst (
  .in_PC(in_PC),
  .imme16(imme16),
  .rt(rc_data),
  .PC_result(brhnz_result)
);

brhz brhz_inst (
  .in_PC(in_PC),
  .imme16(imme16),
  .rt(rc_data),
  .PC_result(brhz_result)
);

brnz brnz_inst (
  .in_PC(in_PC),
  .rt(rc_data),
  .imme16(imme16),
  .PC_result(brnz_result)
);

brsl brsl_inst (
  .in_PC(in_PC),
  .imme16(imme16),
  .PC_result(brsl_result),
  .rt_result(rt_result_temp)
);

brz brz_inst (
  .in_PC(in_PC),
  .rt(rc_data),
  .imme16(imme16),
  .PC_result(brz_result)
);

endmodule