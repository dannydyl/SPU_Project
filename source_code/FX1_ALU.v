module FX1_ALU(
  input [0:6] instr_id,
  input [0:127] ra_data,
  input [0:127] rb_data,
  input [0:127] rc_data, // rc port is also used for instructions that need rt data as an operand
  input [0:7] imme7,
  input [0:9] imme10,
  input [0:15] imme16,
  input [0:17] imme18,

  output reg [0:127] result
);
`include "opcode_package.vh"

wire [0:127] a_result, addx_result, ah_result, ahi_result, ai_result, and_result, andhi_result, 
             andi_result, bg_result, bgx_result, ceq_result, ceqh_result, ceqi_result, ceqhi_result,
             cg_result, cgt_result, cgth_result, cgthi_result, cgti_result, cgx_result, clz_result,
             eqv_result, il_result, ila_result, ilh_result, ilhu_result, iohl_result, nand_result, 
             nor_result, or_result, orhi_result, ori_result, selb_result, sf_result, sfh_result, 
             sfhi_result, sfi_result, sfx_result, xor_result, xorhi_result, xori_result;


always @(*) begin
  case (instr_id) 
    `instr_ID_a:      result = a_result;
    `instr_ID_addx:   result = addx_result;
    `instr_ID_ah:     result = ah_result;
    `instr_ID_ahi:    result = ahi_result;
    `instr_ID_ai:     result = ai_result;
    `instr_ID_and:    result = and_result;
    `instr_ID_andhi:  result = andhi_result;
    `instr_ID_andi:   result = andi_result;
    `instr_ID_bg:     result = bg_result;
    `instr_ID_bgx:    result = bgx_result;
    `instr_ID_ceq:    result = ceq_result;
    `instr_ID_ceqh:   result = ceqh_result;
    `instr_ID_ceqi:   result = ceqi_result;
    `instr_ID_ceqhi:  result = ceqhi_result;
    `instr_ID_cg:     result = cg_result;
    `instr_ID_cgt:    result = cgt_result;
    `instr_ID_cgth:   result = cgth_result;
    `instr_ID_cgthi:  result = cgthi_result;
    `instr_ID_cgti:   result = cgti_result;
    `instr_ID_cgx:    result = cgx_result;
    `instr_ID_clz:    result = clz_result;
    `instr_ID_eqv:    result = eqv_result;
    `instr_ID_il:     result = il_result;
    `instr_ID_ila:    result = ila_result;
    `instr_ID_ilh:    result = ilh_result;
    `instr_ID_ilhu:   result = ilhu_result;
    `instr_ID_iohl:   result = iohl_result;
    `instr_ID_nand:   result = nand_result;
    `instr_ID_nor:    result = nor_result;
    `instr_ID_or:     result = or_result;
    `instr_ID_orhi:   result = orhi_result;
    `instr_ID_ori:    result = ori_result;
    `instr_ID_selb:   result = selb_result;
    `instr_ID_sf:     result = sf_result;
    `instr_ID_sfh:    result = sfh_result;
    `instr_ID_sfhi:   result = sfhi_result;
    `instr_ID_sfi:    result = sfi_result;
    `instr_ID_sfx:    result = sfx_result;
    `instr_ID_xor:    result = xor_result;
    `instr_ID_xorhi:  result = xorhi_result;
    `instr_ID_xori:   result = xori_result;
    default : result = 128'b0;
  endcase
end

// FX1 instantiation
a add_inst(
  .ra(ra_data),
  .rb(rb_data),
  .result(a_result)
);

addx add_extended_inst(
  .ra(ra_data),
  .rb(rb_data),
  .rt(rc_data),
  .result(addx_result)
);

ah ah_inst(
  .ra(ra_data),
  .rb(rb_data),
  .result(ah_result)
);

ahi ahi_inst(
  .ra(ra_data),
  .imme(imme10),
  .result(ahi_result)
);

ai ai_inst(
  .ra(ra_data),
  .imme(imme10),
  .result(ai_result)
);

and_op and_inst(
  .ra(ra_data),
  .rb(rb_data),
  .result(and_result)
);

andhi andhi_inst(
  .ra(ra_data),
  .imme(imme10),
  .result(andhi_result)
);

andi andi_inst(
  .ra(ra_data),
  .imme(imme10),
  .result(andi_result)
);

bg bg_inst(
  .ra(ra_data),
  .rb(rb_data),
  .result(bg_result)
);

bgx bgx_inst(
  .ra(ra_data),
  .rb(rb_data),
  .rt(rc_data),
  .result(bgx_result)
);

ceq ceq_inst(
  .ra(ra_data),
  .rb(rb_data),
  .result(ceq_result)
);

ceqh ceqh_inst(
  .ra(ra_data),
  .rb(rb_data),
  .result(ceqh_result)
);

ceqhi ceqhi_inst(
  .ra(ra_data),
  .imme(imme10),
  .result(ceqhi_result)
);

ceqi ceqi_inst(
  .ra(ra_data),
  .imme(imme10),
  .result(ceqi_result)
);

cg cg_inst(
  .ra(ra_data),
  .rb(rb_data),
  .result(cg_result)
);

cgt cgt_inst(
  .ra(ra_data),
  .rb(rb_data),
  .result(cgt_result)
);

cgth cgth_inst(
  .ra(ra_data),
  .rb(rb_data),
  .result(cgth_result)
);

cgthi cgthi_inst(
  .ra(ra_data),
  .imme(imme10),
  .result(cgthi_result)
);

cgti cgti_inst(
  .ra(ra_data),
  .imme(imme10),
  .result(cgti_result)
);

cgx cgx_inst(
  .ra(ra_data),
  .rb(rb_data),
  .rt(rc_data),
  .result(cgx_result)
);

clz clz_inst(
  .ra(ra_data),
  .result(clz_result)
);

eqv eqv_inst(
  .ra(ra_data),
  .rb(rb_data),
  .result(eqv_result)
);

il il_inst(
  .imme(imme16),
  .result(il_result)
);

ila ila_inst(
  .imme(imme18),
  .result(ila_result)
);

ilh ilh_inst(
  .imme(imme16),
  .result(ilh_result)
);

ilhu ilhu_inst(
  .imme(imme16),
  .result(ilhu_result)
);

iohl iohl_inst(
  .rt(rc_data),
  .imme(imme16),
  .result(iohl_result)
);

nand_op nand_inst(
  .ra(ra_data),
  .rb(rb_data),
  .result(nand_result)
);

nor_op nor_inst(
  .ra(ra_data),
  .rb(rb_data),
  .result(nor_result)
);

or_op or_inst(
  .ra(ra_data),
  .rb(rb_data),
  .result(or_result)
);

orhi orhi_inst(
  .ra(ra_data),
  .imme(imme10),
  .result(orhi_result)
);

ori ori_inst(
  .ra(ra_data),
  .imme(imme10),
  .result(ori_result)
);

selb selb_inst(
  .ra(ra_data),
  .rb(rb_data),
  .rc(rc_data),
  .result(selb_result)
);

sf sf_inst(
  .ra(ra_data),
  .rb(rb_data),
  .result(sf_result)
);

sfh sfh_inst(
  .ra(ra_data),
  .rb(rb_data),
  .result(sfh_result)
);

sfhi sfhi_inst(
  .ra(ra_data),
  .imme(imme10),
  .result(sfhi_result)
);

sfi sfi_inst(
  .ra(ra_data),
  .imme(imme10),
  .result(sfi_result)
);

sfx sfx_inst(
  .ra(ra_data),
  .rb(rb_data),
  .rt(rc_data),
  .result(sfx_result)
);

xor_op xor_inst(
  .ra(ra_data),
  .rb(rb_data),
  .result(xor_result)
);

xorhi xorhi_inst(
  .ra(ra_data),
  .imme(imme10),
  .result(xorhi_result)
);

xori xori_inst(
  .ra(ra_data),
  .imme(imme10),
  .result(xori_result)
);

endmodule