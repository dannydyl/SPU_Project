module BRANCH_ALU(
  input [0:6] instr_id,
  input [0:15] imme16,
  input [0:127] rc_data, // used for rt

  input [0:9] in_PC,

  output reg [0:9] PC_result,
  output reg [0:127] rt_result,
  output reg branch_taken
);

`include "opcode_package.vh"

wire [0:9] br_result, bra_result, brasl_result, brhnz_result, brhz_result, brnz_result, brsl_result, brz_result;
wire [0:127] rt_result_temp;
wire temp_branch_taken;

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
  branch_taken = temp_branch_taken;
end

br br_inst (
  .in_PC(in_PC),
  .imme16(imme16),
  .PC_result(br_result),
  .branch_taken(temp_branch_taken)
);

bra bra_inst (
  .imme16(imme16),
  .PC_result(bra_result),
  .branch_taken(temp_branch_taken)
);

brasl brasl_inst (
  .in_PC(in_PC),
  .imme16(imme16),
  .PC_result(brasl_result),
  .rt_result(rt_result_temp),
  .branch_taken(temp_branch_taken)
);

brhnz brhnz_inst (
  .in_PC(in_PC),
  .imme16(imme16),
  .rt(rc_data),
  .PC_result(brhnz_result),
  .branch_taken(temp_branch_taken)
);

brhz brhz_inst (
  .in_PC(in_PC),
  .imme16(imme16),
  .rt(rc_data),
  .PC_result(brhz_result),
  .branch_taken(temp_branch_taken)
);

brnz brnz_inst (
  .in_PC(in_PC),
  .rt(rc_data),
  .imme16(imme16),
  .PC_result(brnz_result),
  .branch_taken(temp_branch_taken)
);

brsl brsl_inst (
  .in_PC(in_PC),
  .imme16(imme16),
  .PC_result(brsl_result),
  .rt_result(rt_result_temp),
  .branch_taken(temp_branch_taken)
);

brz brz_inst (
  .in_PC(in_PC),
  .rt(rc_data),
  .imme16(imme16),
  .PC_result(brz_result),
  .branch_taken(temp_branch_taken)
);

endmodule