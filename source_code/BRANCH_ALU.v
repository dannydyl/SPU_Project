module BRANCH_ALU(
  input [0:6] instr_id,
  input [0:15] imme16,
  input [0:127] rc_data, // used for rt

  input [0:8] in_PC,

  output reg [0:8] PC_result,
  output reg [0:127] rt_result,
  output reg branch_taken
);

`include "opcode_package.vh"

wire br_taken, bra_taken, brasl_taken, brhnz_taken, brhz_taken;
wire brnz_taken, brsl_taken, brz_taken;
wire [0:8] br_result, bra_result, brasl_result, brhnz_result, brhz_result, brnz_result, brsl_result, brz_result;
wire [0:127] brasl_rt_result, brsl_rt_result;
wire temp_branch_taken;

always @(*) begin

  case (instr_id)
    `instr_ID_br: begin
      PC_result = br_result;
      branch_taken = br_taken;
    end
    `instr_ID_bra: begin
      PC_result = bra_result;
      branch_taken = bra_taken;
    end
    `instr_ID_brasl: begin
      PC_result = brasl_result;
      rt_result = brasl_rt_result;
      branch_taken = brasl_taken;
    end
    `instr_ID_brhnz: begin
      PC_result = brhnz_result;
      branch_taken = brhnz_taken;
    end
    `instr_ID_brhz: begin
      PC_result = brhz_result;
      branch_taken = brhz_taken;
    end
    `instr_ID_brnz: begin
      PC_result = brnz_result;
      branch_taken = brnz_taken;
    end
    `instr_ID_brsl: begin
      PC_result = brsl_result;
      rt_result = brsl_rt_result;
      branch_taken = brsl_taken;
    end
    `instr_ID_brz: begin
      PC_result = brz_result;
      branch_taken = brz_taken;
    end
    default: begin
      PC_result = 10'h0;
      rt_result = 128'h0;
      branch_taken = 1'b0;
    end
  endcase
end

br br_inst (
  .in_PC(in_PC),
  .imme16(imme16),
  .PC_result(br_result),
  .branch_taken(br_taken)
);

bra bra_inst (
  .imme16(imme16),
  .PC_result(bra_result),
  .branch_taken(bra_taken)
);

brasl brasl_inst (
  .in_PC(in_PC),
  .imme16(imme16),
  .PC_result(brasl_result),
  .rt_result(brasl_rt_result),
  .branch_taken(brasl_taken)
);

brhnz brhnz_inst (
  .in_PC(in_PC),
  .imme16(imme16),
  .rt(rc_data),
  .PC_result(brhnz_result),
  .branch_taken(brhnz_taken)
);

brhz brhz_inst (
  .in_PC(in_PC),
  .imme16(imme16),
  .rt(rc_data),
  .PC_result(brhz_result),
  .branch_taken(brhz_taken)
);

brnz brnz_inst (
  .in_PC(in_PC),
  .rt(rc_data),
  .imme16(imme16),
  .PC_result(brnz_result),
  .branch_taken(brnz_taken)
);

brsl brsl_inst (
  .in_PC(in_PC),
  .imme16(imme16),
  .PC_result(brsl_result),
  .rt_result(brsl_rt_result),
  .branch_taken(brsl_taken)
);

brz brz_inst (
  .in_PC(in_PC),
  .rt(rc_data),
  .imme16(imme16),
  .PC_result(brz_result),
  .branch_taken(brz_taken)
);

endmodule