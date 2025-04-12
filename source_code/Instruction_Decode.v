module Instruction_Decode{
  input clk,
  input rst,

  input [0:31] instruction_in1,
  input [0:31] instruction_in2,

  output reg [0:31] full_instr_even,
  output reg [0:6] instr_id_even,
  output reg [0:6] reg_dst_even,
  output reg [0:2] unit_id_even,
  output reg [0:3] latency_even,
  output reg reg_wr_even,
  output reg [0:6] imme7_even,
  output reg [0:9] imme10_even,
  output reg [0:15] imme16_even,
  output reg [0:17] imme18_even,

  output reg [0:6] ra_addr_even,
  output reg [0:6] rb_addr_even,
  output reg [0:6] rc_addr_even,

  output reg [0:31] full_instr_odd,
  output reg [0:6] instr_id_odd,
  output reg [0:6] reg_dst_odd,
  output reg [0:2] unit_id_odd,
  output reg [0:3] latency_odd,
  output reg reg_wr_odd,
  output reg [0:6] imme7_odd,
  output reg [0:9] imme10_odd,
  output reg [0:15] imme16_odd,
  output reg [0:17] imme18_odd,

  output reg [0:6] ra_addr_odd,
  output reg [0:6] rb_addr_odd,
  output reg [0:6] rc_addr_odd,

  output reg instr1_type,
  output reg instr2_type
};

`include "opcode_package.vh"

localparam RRR = 3'b000;
localparam RR = 3'b001;
localparam RI7 = 3'b010;
localparam RI10 = 3'b011;
localparam RI16 = 3'b100;
localparam RI18 = 3'b101;


wire [0:10] temp_opcode1;
wire [0:10] temp_opcode2;

assign temp_opcode1 = instruction_in1[0:10];
assign temp_opcode2 = instruction_in2[0:10];

reg [0:2] instr_format_even;
reg [0:2] instr_format_odd;

// 1 for even, 0 for odd
// reg instr1_type;
// reg instr2_type;

// ------------- for instruction 1 -------------------
always @(*) begin

  // -------------- RRR ------------------
  if (temp_opcode1[0:1] == 2'b11) begin
    instr_format_even = RRR;
    case (temp_opcode1)
      `op_fma: instr_id_even = `instr_ID_fma;
      `op_fms: instr_id_even = `instr_ID_fms;
      `op_fnms: instr_id_even = `instr_ID_fnms;
      `op_mpya: instr_id_even = `instr_ID_mpya;
      default: instr_id_even = 7'b0;
    endcase
    full_instr_even = instruction_in1;
    reg_dst_even = instruction_in1[4:10];
    unit_id_even = 3'b011;
    latency_even = 4'd8;
    reg_wr_even = 1'b1;
    ra_addr_even = instruction_in1[18:24];
    rb_addr_even = instruction_in1[11:17];
    rc_addr_even = instruction_in1[25:31];
    instr1_type = 1'b1;
  end 
  
  else if (temp_opcode1[0:3] == `op_selb) begin
    instr_format_even = RRR;
    full_instr_even = instruction_in1;
    instr_id_even = `instr_ID_selb;
    reg_dst_even = instruction_in1[4:10];
    unit_id_even = 3'b001;
    latency_even = 4'd3;
    reg_wr_even = 1'b1;
    ra_addr_even = instruction_in1[18:24];
    rb_addr_even = instruction_in1[11:17];
    rc_addr_even = instruction_in1[25:31];
    instr1_type = 1'b1;
  end 
  
  // -------------- R18 ------------------
  else if (temp_opcode1[0:6] == `op_ila) begin
    instr_format_even = RI18;
    full_instr_even = instruction_in1;
    instr_id_even = `instr_ID_ila;
    reg_dst_even = instruction_in1[25:31];
    unit_id_even = 3'b001;
    latency_even = 4'd3;
    reg_wr_even = 1'b1;
    imme18_even = instruction_in1[7:24];
    instr1_type = 1'b1;
  end

  // -------------- RI10 ---------------------
  else if (temp_opcode1[0:7] == `op_ahi || temp_opcode1[0:7] == `op_ai ||
           temp_opcode1[0:7] == `op_andhi || temp_opcode1[0:7] == `op_andi ||
           temp_opcode1[0:7] == `op_ceqhi || temp_opcode1[0:7] == `op_ceqi ||
           temp_opcode1[0:7] == `op_cgtihi || temp_opcode1[0:7] == `op_cgti ||
           temp_opcode1[0:7] == `op_xorhi || temp_opcode1[0:7] == `op_xori ||
           temp_opcode1[0:7] == `op_orhi || temp_opcode1[0:7] == `op_ori ||
           temp_opcode1[0:7] == `op_sfhi || temp_opcode1[0:7] == `op_sfi ||
           temp_opcode1[0:7] == `op_mpyi || temp_opcode1[0:7] == `op_mpyui ||
          temp_opcode1[0:7] == `op_lqd || temp_opcode1[0:7] == `op_stqd || ) begin

    // i dont think below two are necessary
    // instr_format_even = RI10;
    // full_instr_even = instruction_in1;


    if (temp_opcode1[0:7] == `op_ahi) begin
      instr_id_even = `instr_ID_ahi;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr1_type = 1'b1;
    end

    else if (temp_opcode1[0:7] == `op_ai) begin
      instr_id_even = `instr_ID_ai;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr1_type = 1'b1;
    end

    else if (temp_opcode1[0:7] == `op_andhi) begin
      instr_id_even = `instr_ID_ahi;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr1_type = 1'b1;
    end

    else if (temp_opcode1[0:7] == `op_andi) begin
      instr_id_even = `instr_ID_andi;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr1_type = 1'b1;
    end

    else if (temp_opcode1[0:7] == `op_ceqhi) begin
      instr_id_even = `instr_ID_ceqhi;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr1_type = 1'b1;
    end

    else if (temp_opcode1[0:7] == `op_ceqi) begin
      instr_id_even = `instr_ID_ceqi;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr1_type = 1'b1;
    end

    else if (temp_opcode1[0:7] == `op_cgtihi) begin
      instr_id_even = `instr_ID_cgtihi;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr1_type = 1'b1;
    end

    else if (temp_opcode1[0:7] == `op_cgti) begin
      instr_id_even = `instr_ID_cgti;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr1_type = 1'b1;
    end

    else if (temp_opcode1[0:7] == `op_xorhi) begin
      instr_id_even = `instr_ID_xorhi;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr1_type = 1'b1;
    end

    else if (temp_opcode1[0:7] == `op_xori) begin
      instr_id_even = `instr_ID_xori;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr1_type = 1'b1;
    end

    else if (temp_opcode1[0:7] == `op_orhi) begin
      instr_id_even = `instr_ID_orhi;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr1_type = 1'b1;
    end

    else if (temp_opcode1[0:7] == `op_ori) begin
      instr_id_even = `instr_ID_ori;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr1_type = 1'b1;
    end

    else if (temp_opcode1[0:7] == `op_sfhi) begin
      instr_id_even = `instr_ID_sfhi;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr1_type = 1'b1;
    end

    else if (temp_opcode1[0:7] == `op_sfi) begin
      instr_id_even = `instr_ID_sfi;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr1_type = 1'b1;
    end

    else if (temp_opcode1[0:7] == `op_mpyi) begin
      instr_id_even = `instr_ID_mpyi;
      unit_id_even = 3'd3;
      latency_even = 4'd8;
      reg_wr_even = 1'b1;
      instr1_type = 1'b1;
    end

    else if (temp_opcode1[0:7] == `op_mpyui) begin
      instr_id_even = `instr_ID_mpyui;
      unit_id_even = 3'd3;
      latency_even = 4'd8;
      reg_wr_even = 1'b1;
      instr1_type = 1'b1;
    end

    else if (temp_opcode1[0:7] == `op_lqd) begin
      instr_id_odd = `instr_ID_lqd;
      unit_id_odd = 3'b110;
      latency_odd = 4'd7;
      reg_wr_odd = 1'b1;
      instr1_type = 1'b0;
    end

    else if (temp_opcode1[0:7] == `op_stqd) begin
      instr_id_odd = `instr_ID_stqd;
      unit_id_odd = 3'b110;
      latency_odd = 4'd7;
      reg_wr_odd = 1'b0;
      instr1_type = 1'b0;
    end

    if (instr1_type) begin
      imme7_even = instruction_in1[8:17];
      reg_dst_even = instruction_in1[25:31];
      ra_addr_even = instruction_in1[18:24];
      rc_addr_even = instruction_in1[25:31]; // for rt data
    end else begin
      imme7_odd = instruction_in1[8:17];
      reg_dst_odd = instruction_in1[25:31];
      ra_addr_odd = instruction_in1[18:24];
      rc_addr_odd = instruction_in1[25:31]; // for rt data
    end
  end

  // -------------- RI16 -----------------------

  else if (temp_opcode1[0:8] == `op_ilh || temp_opcode1[0:8] == `op_ilhu || temp_opcode1[0:8] == `op_il ||
            temp_opcode1[0:8] == `op_iohl || temp_opcode1[0:8] == `op_lqa || temp_opcode1[0:8] == `op_stqa ||
            temp_opcode1[0:8] == `op_bra || temp_opcode1[0:8] == `op_brhnz || temp_opcode1[0:8] == `op_brz ||
            temp_opcode1[0:8] == `op_brnz || temp_opcode1[0:8] == `op_brasl || temp_opcode1[0:8] == `op_brsl ||
            temp_opcode1[0:8] == `op_br || temp_opcode1[0:8] == `op_brhz) begin

    if(temp_opcode1[0:8] == `op_ilh) begin
      instr_id_even = `instr_ID_ilh;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr1_type = 1'b1;
    end

    else if(temp_opcode1[0:8] == `op_ilhu) begin
      instr_id_even = `instr_ID_ilhu;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr1_type = 1'b1;
    end

    else if(temp_opcode1[0:8] == `op_il) begin
      instr_id_even = `instr_ID_il;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr1_type = 1'b1;
    end

    else if(temp_opcode1[0:8] == `op_iohl) begin
      instr_id_even = `instr_ID_iohl;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr1_type = 1'b1;
    end

    else if(temp_opcode1[0:8] == `op_lqa) begin
      instr_id_odd = `instr_ID_lqa;
      unit_id_odd = 3'b110;
      latency_odd = 4'd7;
      reg_wr_odd = 1'b0;
      instr1_type = 1'b0; 
    end

    else if(temp_opcode1[0:8] == `op_stqa) begin
      instr_id_odd = `instr_ID_stqa;
      unit_id_odd = 3'b110;
      latency_odd = 4'd7;
      reg_wr_odd = 1'b0; 
      instr1_type = 1'b0; 
    end

    else if(temp_opcode1[0:8] == `op_bra) begin
        instr_id_odd = `instr_ID_bra; 
        unit_id_odd = 3'b111; 
        latency_odd = 4'd2; 
        reg_wr_odd = 1'b0; 
        instr1_type = 1'b0;
    end

    else if(temp_opcode1[0:8] == `op_brhnz) begin
        instr_id_odd = `instr_ID_brhnz; 
        unit_id_odd = 3'b111; 
        latency_odd = 4'd2; 
        reg_wr_odd = 1'b0; 
        instr1_type = 1'b0;
    end

    else if(temp_opcode1[0:8] == `op_brz) begin
        instr_id_odd = `instr_ID_brz; 
        unit_id_odd = 3'b111; 
        latency_odd = 4'd2; 
        reg_wr_odd = 1'b0; 
        instr1_type = 1'b0;
    end

    else if(temp_opcode1[0:8] == `op_brnz) begin
        instr_id_odd = `instr_ID_brnz; 
        unit_id_odd = 3'b111; 
        latency_odd = 4'd2; 
        reg_wr_odd = 1'b0; 
        instr1_type = 1'b0;
    end

    else if(temp_opcode1[0:8] == `op_brasl) begin
        instr_id_odd = `instr_ID_brasl; 
        unit_id_odd = 3'b111; 
        latency_odd = 4'd2; 
        reg_wr_odd = 1'b0; 
        instr1_type = 1'b0;
    end

    else if(temp_opcode1[0:8] == `op_brsl) begin
        instr_id_odd = `instr_ID_brsl; 
        unit_id_odd = 3'b111; 
        latency_odd = 4'd2; 
        reg_wr_odd = 1'b0; 
        instr1_type = 1'b0;
    end

    else if(temp_opcode1[0:8] == `op_br) begin
      instr_id_odd = `instr_ID_br;
      unit_id_odd = 3'b111; 
      latency_odd = 4'd2; 
      reg_wr_odd = 1'b0; 
      instr1_type = 1'b0;
    end

    else if(temp_opcode1[0:8] == `op_brhz) begin
      instr_id_odd = `instr_ID_brhz;
      unit_id_odd = 3'b001;
      latency_odd = 4'd2;
      reg_wr_odd = 1'b1;
      instr1_type = 1'b0;
    end

    if (instr1_type) begin
      imme16_even = instruction_in1[9:24];
      reg_dst_even = instruction_in1[25:31];
      rc_addr_even = instruction_in1[25:31]; // for rt data
    end else begin
      imme16_odd = instruction_in1[9:24];
      reg_dst_odd = instruction_in1[25:31];
      rc_addr_odd = instruction_in1[25:31]; // for rt data
    end
  end

  // -------------- RI7 -----------------------
  else if (temp_opcode1 == `op_rothi || temp_opcode1 == `op_roti ||
           temp_opcode1 == `op_shlhi || temp_opcode1 == `op_shli ||
           temp_opcode1 == `op_rotqbyi || temp_opcode1 == `op_rotqbii ||
           temp_opcode1 == `op_shlqbii || temp_opcode1 == `op_shlqbyi) begin

    if (temp_opcode1 == `op_rothi) begin
      instr_id_even = `instr_ID_rothi;
      unit_id_even = 3'd2;
      latency_even = 4'd4;
      reg_wr_even = 1'b1;
      instr1_type = 1'b1;
    end

    else if (temp_opcode1 == `op_roti) begin
      instr_id_even = `instr_ID_roti;
      unit_id_even = 3'd2;
      latency_even = 4'd4;
      reg_wr_even = 1'b1;
      instr1_type = 1'b1;
    end

    else if (temp_opcode1 == `op_shlhi) begin
      instr_id_even = `instr_ID_shlhi;
      unit_id_even = 3'd2;
      latency_even = 4'd4;
      reg_wr_even = 1'b1;
      instr1_type = 1'b1;
    end

    else if (temp_opcode1 == `op_shli) begin
      instr_id_even = `instr_ID_shli;
      unit_id_even = 3'd5;
      latency_even = 4'd4;
      reg_wr_even = 1'b1;
      instr1_type = 1'b1;
    end

    else if (temp_opcode1 == `op_rotqbyi) begin
      instr_id_odd = `instr_ID_rotqbyi; 
      unit_id_odd = 3'd5; 
      latency_odd = 4'd4; 
      reg_wr_odd = 1'b1; 
      instr1_type = 1'b0; 
    end

    else if (temp_opcode1 == `op_rotqbii) begin
      instr_id_odd = `instr_ID_rotqbii; 
      unit_id_odd = 3'd5; 
      latency_odd = 4'd4; 
      reg_wr_odd = 1'b1; 
      instr1_type = 1'b0; 
    end

    else if (temp_opcode1 == `op_shlqbii) begin
      instr_id_odd = `instr_ID_shlqbii; 
      unit_id_odd = 3'd5; 
      latency_odd = 4'd4; 
      reg_wr_odd = 1'b1; 
      instr1_type = 1'b0; 
    end

    else if (temp_opcode1 == `op_shlqbyi) begin
      instr_id_odd = `instr_ID_shlqbyi; 
      unit_id_odd = 3'd5; 
      latency_odd = 4'd4;
    end

    if (instr1_type) begin
      imme7_even = instruction_in1[11:17];
      reg_dst_even = instruction_in1[25:31];
      ra_addr_even = instruction_in1[18:24];
      rc_addr_even = instruction_in1[25:31]; // for rt data
    end else begin
      imme7_odd = instruction_in1[11:17];
      reg_dst_odd = instruction_in1[25:31];
      ra_addr_odd = instruction_in1[18:24];
      rc_addr_odd = instruction_in1[25:31];
    end
  end

  // -------------- RR ----------------------
  else if (temp_opcode1 == `op_addx || temp_opcode1 == `op_ah || temp_opcode1 == `op_a || 
            temp_opcode1 == `op_and || temp_opcode1 == `op_bg || temp_opcode1 == `op_bgx ||
            temp_opcode1 == `op_cg || temp_opcode1 == `op_cgx || temp_opcode1 == `op_ceqh ||
            temp_opcode1 == `op_ceq || temp_opcode1 == `op_cgth || temp_opcode1 == `op_cgt ||
            temp_opcode1 == `op_clz || temp_opcode1 == `op_eqv || temp_opcode1 == `op_xor ||
            temp_opcode1 == `op_nand || temp_opcode1 == `op_nor || temp_opcode1 == `op_or ||
            temp_opcode1 == `op_sfx || temp_opcode1 == `op_sfh || temp_opcode1 == `op_sf ||
            temp_opcode1 == `op_roth || temp_opcode1 == `op_rot || temp_opcode1 == `op_shlh ||
            temp_opcode1 == `op_shl || temp_opcode1 == `op_fa || temp_opcode1 == `op_fm ||
            temp_opcode1 == `op_fs || temp_opcode1 == `op_mpy || temp_opcode1 == `op_mpyu ||
            temp_opcode1 == `op_mpyh || temp_opcode1 == `op_cntb || temp_opcode1 == `op_absdb ||
            temp_opcode1 == `op_sumb || temp_opcode1 == `op_avgb || temp_opcode1 == `op_rotqby ||
            temp_opcode1 == `op_rotqbi || temp_opcode1 == `op_shlqbi || temp_opcode1 == `op_shlqby) begin

    if (temp_opcode1 == `op_addx) begin
      instr_id_even = `instr_ID_addx;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr1_type = 1'b1;
    end

    else if (temp_opcode1 == `op_ah) begin
      instr_id_even = `instr_ID_ah;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr1_type = 1'b1;
    end

    else if (temp_opcode1 == `op_a) begin
      instr_id_even = `instr_ID_a;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr1_type = 1'b1;
    end

    else if (temp_opcode1 == `op_and) begin
      instr_id_even = `instr_ID_and;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr1_type = 1'b1;
    end

    else if (temp_opcode1 == `op_bg) begin
      instr_id_even = `instr_ID_bg;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr1_type = 1'b1;
    end

    else if (temp_opcode1 == `op_bgx) begin
      instr_id_even = `instr_ID_bgx; 
      unit_id_even = 3'b001; 
      latency_even = 4'd3; 
      reg_wr_even = 1'b1; 
      instr1_type = 1'b0; 
    end

    else if (temp_opcode1 == `op_cg) begin
      instr_id_even = `instr_ID_cg; 
      unit_id_even = 3'b001; 
      latency_even = 4'd3; 
      reg_wr_even = 1'b0; 
      instr1_type = 1'b0; 
    end

    else if (temp_opcode1 == `op_cgx) begin
      instr_id_even = `instr_ID_cgx;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr1_type = 1'b1;
    end

    else if (temp_opcode1 == `op_ceqh) begin
        instr_id_even = `instr_ID_ceqh;
        unit_id_even = 3'b001;
        latency_even = 4'd3;
        reg_wr_even = 1'b1;
        instr1_type = 1'b1;
    end

    else if (temp_opcode1 == `op_ceq) begin
        instr_id_even = `instr_ID_ceq;
        unit_id_even = 3'b001;
        latency_even = 4'd3;
        reg_wr_even = 1'b1;
        instr1_type = 1'b1;
    end

    else if (temp_opcode1 == `op_cgth) begin
        instr_id_even = `instr_ID_cgth;
        unit_id_even = 3'b001;
        latency_even = 4'd3;
        reg_wr_even = 1'b1;
        instr1_type = 1'b1;
    end

    else if (temp_opcode1 == `op_cgt) begin
        instr_id_even = `instr_ID_cgt; 
        unit_id_even = 3'b001; 
        latency_even = 4'd3; 
        reg_wr_even = 1'b1; 
        instr1_type = 1'b0; 
    end

    else if (temp_opcode1 == `op_clz) begin
      instr_id_even = `instr_ID_clz;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr1_type = 1'b1;
    end

    else if (temp_opcode1 == `op_eqv) begin
      instr_id_even = `instr_ID_eqv;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr1_type = 1'b1;
    end

    else if (temp_opcode1 == `op_xor) begin
      instr_id_even = `instr_ID_xor; 
      unit_id_even = 3'b001; 
      latency_even = 4'd3; 
      reg_wr_even = 1'b0; 
      instr1_type = 1'b0; 
    end

    else if (temp_opcode1 == `op_nand) begin
      instr_id_even = `instr_ID_nand; 
      unit_id_even = 3'b001; 
      latency_even = 4'd3; 
      reg_wr_even = 1'b0; 
      instr1_type = 1'b0; 
    end

    else if (temp_opcode1 == `op_nor) begin
      instr_id_even = `instr_ID_nor; 
      unit_id_even = 3'b001; 
      latency_even = 4'd3; 
      reg_wr_even = 1'b0; 
      instr1_type = 1'b0; 
    end

    else if (temp_opcode1 == `op_or) begin
      instr_id_even = `instr_ID_or; 
      unit_id_even = 3'b001; 
      latency_even = 4'd3; 
      reg_wr_even = 1'b0; 
      instr1_type = 1'b0; 
    end

    else if (temp_opcode1 == `op_sfx) begin
      instr_id_even = `instr_ID_sfx;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr1_type = 1'b1;
    end

    else if (temp_opcode1 == `op_sfh) begin
      instr_id_even = `instr_ID_sfh;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr1_type = 1'b1;
    end

    else if (temp_opcode1 == `op_sf) begin
      instr_id_even = `instr_ID_sf;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr1_type = 1'b1;
    end

    else if (temp_opcode1 == `op_roth) begin
      instr_id_even = `instr_ID_roth;
      unit_id_even = 3'b010;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr1_type = 1'b1;
    end

    else if (temp_opcode1 == `op_rot) begin
      instr_id_even = `instr_ID_rot; 
      unit_id_even = 3'b010; 
      latency_even = 4'd3; 
      reg_wr_even = 1'b1; 
      instr1_type = 1'b1; 
    end

    else if (temp_opcode1 == `op_shlh) begin
      instr_id_even = `instr_ID_shlh;
      unit_id_even = 3'b010;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr1_type = 1'b1;
  end

    else if (temp_opcode1 == `op_shl) begin
      instr_id_even = `instr_ID_shl; 
      unit_id_even = 3'b010; 
      latency_even = 4'd3; 
      reg_wr_even = 1'b1; 
      instr1_type = 1'b1; 
    end

    else if (temp_opcode1 == `op_fa) begin
      instr_id_even = `instr_ID_fa;
      unit_id_even = 3'b011;
      latency_even = 4'd7;
      reg_wr_even = 1'b1;
      instr1_type = 1'b1;
    end

    else if (temp_opcode1 == `op_fm) begin
      instr_id_even = `instr_ID_fm;
      unit_id_even = 3'b011;
      latency_even = 4'd7;
      reg_wr_even = 1'b1;
      instr1_type = 1'b1;
    end

    else if (temp_opcode1 == `op_fs) begin
      instr_id_even = `instr_ID_fs;
      unit_id_even = 3'b011;
      latency_even = 4'd7;
      reg_wr_even = 1'b1;
      instr1_type = 1'b1;
    end

    else if (temp_opcode1 == `op_mpy) begin
      instr_id_even = `instr_ID_mpy; 
      unit_id_even = 3'b011; 
      latency_even = 4'd8; 
      reg_wr_even = 1'b1; 
      instr1_type = 1'b1; 
    end

    else if (temp_opcode1 == `op_mpyu) begin
      instr_id_even = `instr_ID_mpyu; 
      unit_id_even = 3'b011; 
      latency_even = 4'd8; 
      reg_wr_even = 1'b1; 
      instr1_type = 1'b1; 
    end

    else if (temp_opcode1 == `op_mpyh) begin
      instr_id_even = `instr_ID_mpyh; 
      unit_id_even = 3'b011; 
      latency_even = 4'd8; 
      reg_wr_even = 1'b1; 
      instr1_type = 1'b1;
    end

    else if (temp_opcode1 == `op_cntb) begin
      instr_id_even = `instr_ID_cntb; 
      unit_id_even = 3'd4; 
      latency_even = 4'd4; 
      reg_wr_even = 1'b1; 
      instr1_type = 1'b1; 
    end

    else if (temp_opcode1 == `op_absdb) begin
      instr_id_even = `instr_ID_absdb; 
      unit_id_even = 3'd4; 
      latency_even = 4'd4; 
      reg_wr_even = 1'b1; 
      instr1_type = 1'b1; 
    end

    else if (temp_opcode1 == `op_sumb) begin
      instr_id_even = `instr_ID_sumb; 
      unit_id_even = 3'd4; 
      latency_even = 4'd4; 
      reg_wr_even = 1'b1; 
      instr1_type = 1'b1; 
    end

    else if (temp_opcode1 == `op_avgb) begin
      instr_id_even = `instr_ID_avgb;
      unit_id_even = 3'd4;
      latency_even = 4'd4;
      reg_wr_even = 1'b1;
      instr1_type = 1'b1;
    end

    else if (temp_opcode1 == `op_rotqby) begin
      instr_id_odd = `instr_ID_rotqby;
      unit_id_odd = 3'd5;
      latency_odd = 4'd4;
      reg_wr_odd = 1'b1;
      instr1_type = 1'b0;
    end

    else if (temp_opcode1 == `op_rotqbi) begin
      instr_id_odd = `instr_ID_rotqbi;
      unit_id_odd = 3'd5;
      latency_odd = 4'd4;
      reg_wr_odd = 1'b1;
      instr1_type = 1'b0;
    end

    else if (temp_opcode1 == `op_shlqbi) begin
      instr_id_odd = `instr_ID_shlqbi;
      unit_id_odd = 3'd5;
      latency_odd = 4'd4;
      reg_wr_odd = 1'b1;
      instr1_type = 1'b0;
    end

    else if (temp_opcode1 == `op_shlqby) begin
      instr_id_odd = `instr_ID_shlqby;
      unit_id_odd = 3'd5;
      latency_odd = 4'd4;
      reg_wr_odd = 1'b1;
      instr1_type = 1'b0;
    end

    if (instr1_type) begin
      reg_dst_even = instruction_in1[25:31];
      ra_addr_even = instruction_in1[18:24];
      rb_addr_even = instruction_in1[11:17];
      rc_addr_even = instruction_in1[25:31]; // for rt data
    end else begin
      reg_dst_odd = instruction_in1[25:31];
      ra_addr_odd = instruction_in1[18:24];
      rb_addr_odd = instruction_in1[11:17];
      rc_addr_odd = instruction_in1[25:31]; // for rt data
    end
  end
end

// ------------- for instruction 2 -------------------
always @(*) begin

  // -------------- RRR ------------------
  if (temp_opcode2[0:1] == 2'b11) begin
    instr_format_even = RRR;
      case (temp_opcode2)
        `op_fma: instr_id_even = `instr_ID_fma;
        `op_fms: instr_id_even = `instr_ID_fms;
        `op_fnms: instr_id_even = `instr_ID_fnms;
        `op_mpya: instr_id_even = `instr_ID_mpya;
        default: instr_id_even = 7'b0;
      endcase
    full_instr_even = instruction_in1;
    reg_dst_even = instruction_in2[4:10];
    unit_id_even = 3'b011;
    latency_even = 4'd8;
    reg_wr_even = 1'b1;
    ra_addr_even = instruction_in2[18:24];
    rb_addr_even = instruction_in2[11:17];
    rc_addr_even = instruction_in2[25:31];
    instr2_type = 1'b1;
  end 

  else if (temp_opcode2[0:3] == `op_selb) begin
    instr_format_even = RRR;
    full_instr_even = instruction_in2;
    instr_id_even = `instr_ID_selb;
    reg_dst_even = instruction_in2[4:10];
    unit_id_even = 3'b001;
    latency_even = 4'd3;
    reg_wr_even = 1'b1;
    ra_addr_even = instruction_in2[18:24];
    rb_addr_even = instruction_in2[11:17];
    rc_addr_even = instruction_in2[25:31];
    instr2_type = 1'b1;
  end 

  // -------------- R18 ------------------
  else if (temp_opcode2[0:6] == `op_ila) begin
    instr_format_even = RI18;
    full_instr_even = instruction_in2;
    instr_id_even = `instr_ID_ila;
    reg_dst_even = instruction_in2[25:31];
    unit_id_even = 3'b001;
    latency_even = 4'd3;
    reg_wr_even = 1'b1;
    imme18_even = instruction_in2[7:24];
    instr2_type = 1'b1;
  end

  // -------------- RI10 ---------------------
  else if (temp_opcode2[0:7] == `op_ahi || temp_opcode2[0:7] == `op_ai ||
          temp_opcode2[0:7] == `op_andhi || temp_opcode2[0:7] == `op_andi ||
          temp_opcode2[0:7] == `op_ceqhi || temp_opcode2[0:7] == `op_ceqi ||
          temp_opcode2[0:7] == `op_cgtihi || temp_opcode2[0:7] == `op_cgti ||
          temp_opcode2[0:7] == `op_xorhi || temp_opcode2[0:7] == `op_xori ||
          temp_opcode2[0:7] == `op_orhi || temp_opcode2[0:7] == `op_ori ||
          temp_opcode2[0:7] == `op_sfhi || temp_opcode2[0:7] == `op_sfi ||
          temp_opcode2[0:7] == `op_mpyi || temp_opcode2[0:7] == `op_mpyui ||
          temp_opcode2[0:7] == `op_lqd || temp_opcode2[0:7] == `op_stqd) begin

    if (temp_opcode2[0:7] == `op_ahi) begin
      instr_id_even = `instr_ID_ahi;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr2_type = 1'b1;
    end else if (temp_opcode2[0:7] == `op_ai) begin
      instr_id_even = `instr_ID_ai;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr2_type = 1'b1;
    end else if (temp_opcode2[0:7] == `op_andhi) begin
      instr_id_even = `instr_ID_ahi;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr2_type = 1'b1;
    end else if (temp_opcode2[0:7] == `op_andi) begin
      instr_id_even = `instr_ID_andi;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr2_type = 1'b1;
    end else if (temp_opcode2[0:7] == `op_ceqhi) begin
      instr_id_even = `instr_ID_ceqhi;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr2_type = 1'b1;
    end else if (temp_opcode2[0:7] == `op_ceqi) begin
      instr_id_even = `instr_ID_ceqi;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr2_type = 1'b1;
    end else if (temp_opcode2[0:7] == `op_cgtihi) begin
      instr_id_even = `instr_ID_cgtihi;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr2_type = 1'b1;
    end else if (temp_opcode2[0:7] == `op_cgti) begin
      instr_id_even = `instr_ID_cgti;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr2_type = 1'b1;
    end else if (temp_opcode2[0:7] == `op_xorhi) begin
      instr_id_even = `instr_ID_xorhi;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr2_type = 1'b1;
    end else if (temp_opcode2[0:7] == `op_xori) begin
      instr_id_even = `instr_ID_xori;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr2_type = 1'b1;
    end else if (temp_opcode2[0:7] == `op_orhi) begin
      instr_id_even = `instr_ID_orhi;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr2_type = 1'b1;
    end else if (temp_opcode2[0:7] == `op_ori) begin
      instr_id_even = `instr_ID_ori;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr2_type = 1'b1;
    end else if (temp_opcode2[0:7] == `op_sfhi) begin
      instr_id_even = `instr_ID_sfhi;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr2_type = 1'b1;
    end else if (temp_opcode2[0:7] == `op_sfi) begin
      instr_id_even = `instr_ID_sfi;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr2_type = 1'b1;
    end else if (temp_opcode2[0:7] == `op_mpyi) begin
      instr_id_even = `instr_ID_mpyi;
      unit_id_even = 3'd3;
      latency_even = 4'd8;
      reg_wr_even = 1'b1;
      instr2_type = 1'b1;
    end else if (temp_opcode2[0:7] == `op_mpyui) begin
      instr_id_even = `instr_ID_mpyui;
      unit_id_even = 3'd3;
      latency_even = 4'd8;
      reg_wr_even = 1'b1;
      instr2_type = 1'b1;
    end else if (temp_opcode2[0:7] == `op_lqd) begin
      instr_id_odd = `instr_ID_lqd;
      unit_id_odd = 3'b110;
      latency_odd = 4'd7;
      reg_wr_odd = 1'b1;
      instr2_type = 1'b0;
    end else if (temp_opcode2[0:7] == `op_stqd) begin
      instr_id_odd = `instr_ID_stqd;
      unit_id_odd = 3'b110;
      latency_odd = 4'd7;
      reg_wr_odd = 1'b0;
      instr2_type = 1'b0;
    end

    if (instr2_type) begin
      imme7_even = instruction_in2[8:17];
      reg_dst_even = instruction_in2[25:31];
      ra_addr_even = instruction_in2[18:24];
      rc_addr_even = instruction_in2[25:31];
    end else begin
      imme7_odd = instruction_in2[8:17];
      reg_dst_odd = instruction_in2[25:31];
      ra_addr_odd = instruction_in2[18:24];
      rc_addr_odd = instruction_in2[25:31];
    end
  end

  // -------------- RI16 -----------------------

else if (temp_opcode2[0:8] == `op_ilh || temp_opcode2[0:8] == `op_ilhu || temp_opcode2[0:8] == `op_il ||
         temp_opcode2[0:8] == `op_iohl || temp_opcode2[0:8] == `op_lqa || temp_opcode2[0:8] == `op_stqa ||
         temp_opcode2[0:8] == `op_bra || temp_opcode2[0:8] == `op_brhnz || temp_opcode2[0:8] == `op_brz ||
         temp_opcode2[0:8] == `op_brnz || temp_opcode2[0:8] == `op_brasl || temp_opcode2[0:8] == `op_brsl ||
         temp_opcode2[0:8] == `op_br || temp_opcode2[0:8] == `op_brhz) begin

  if(temp_opcode2[0:8] == `op_ilh) begin
    instr_id_even = `instr_ID_ilh;
    unit_id_even = 3'b001;
    latency_even = 4'd3;
    reg_wr_even = 1'b1;
    instr2_type = 1'b1;
  end

  else if(temp_opcode2[0:8] == `op_ilhu) begin
    instr_id_even = `instr_ID_ilhu;
    unit_id_even = 3'b001;
    latency_even = 4'd3;
    reg_wr_even = 1'b1;
    instr2_type = 1'b1;
  end

  else if(temp_opcode2[0:8] == `op_il) begin
    instr_id_even = `instr_ID_il;
    unit_id_even = 3'b001;
    latency_even = 4'd3;
    reg_wr_even = 1'b1;
    instr2_type = 1'b1;
  end

  else if(temp_opcode2[0:8] == `op_iohl) begin
    instr_id_even = `instr_ID_iohl;
    unit_id_even = 3'b001;
    latency_even = 4'd3;
    reg_wr_even = 1'b1;
    instr2_type = 1'b1;
  end

  else if(temp_opcode2[0:8] == `op_lqa) begin
    instr_id_odd = `instr_ID_lqa;
    unit_id_odd = 3'b110;
    latency_odd = 4'd7;
    reg_wr_odd = 1'b0;
    instr2_type = 1'b0; 
  end

  else if(temp_opcode2[0:8] == `op_stqa) begin
    instr_id_odd = `instr_ID_stqa;
    unit_id_odd = 3'b110;
    latency_odd = 4'd7;
    reg_wr_odd = 1'b0; 
    instr2_type = 1'b0; 
  end

  else if(temp_opcode2[0:8] == `op_bra) begin
    instr_id_odd = `instr_ID_bra; 
    unit_id_odd = 3'b111; 
    latency_odd = 4'd2; 
    reg_wr_odd = 1'b0; 
    instr2_type = 1'b0;
  end

  else if(temp_opcode2[0:8] == `op_brhnz) begin
    instr_id_odd = `instr_ID_brhnz; 
    unit_id_odd = 3'b111; 
    latency_odd = 4'd2; 
    reg_wr_odd = 1'b0; 
    instr2_type = 1'b0;
  end

  else if(temp_opcode2[0:8] == `op_brz) begin
    instr_id_odd = `instr_ID_brz; 
    unit_id_odd = 3'b111; 
    latency_odd = 4'd2; 
    reg_wr_odd = 1'b0; 
    instr2_type = 1'b0;
  end

  else if(temp_opcode2[0:8] == `op_brnz) begin
    instr_id_odd = `instr_ID_brnz; 
    unit_id_odd = 3'b111; 
    latency_odd = 4'd2; 
    reg_wr_odd = 1'b0; 
    instr2_type = 1'b0;
  end

  else if(temp_opcode2[0:8] == `op_brasl) begin
    instr_id_odd = `instr_ID_brasl; 
    unit_id_odd = 3'b111; 
    latency_odd = 4'd2; 
    reg_wr_odd = 1'b0; 
    instr2_type = 1'b0;
  end

  else if(temp_opcode2[0:8] == `op_brsl) begin
    instr_id_odd = `instr_ID_brsl; 
    unit_id_odd = 3'b111; 
    latency_odd = 4'd2; 
    reg_wr_odd = 1'b0; 
    instr2_type = 1'b0;
  end

  else if(temp_opcode2[0:8] == `op_br) begin
    instr_id_odd = `instr_ID_br;
    unit_id_odd = 3'b111; 
    latency_odd = 4'd2; 
    reg_wr_odd = 1'b0; 
    instr2_type = 1'b0;
  end

  else if(temp_opcode2[0:8] == `op_brhz) begin
    instr_id_odd = `instr_ID_brhz;
    unit_id_odd = 3'b001;
    latency_odd = 4'd2;
    reg_wr_odd = 1'b1;
    instr2_type = 1'b0;
  end

  if (instr2_type) begin
    imme16_even = instruction_in1[9:24];
    reg_dst_even = instruction_in1[25:31];
    rc_addr_even = instruction_in1[25:31]; // for rt data
  end else begin
    imme16_odd = instruction_in1[9:24];
    reg_dst_odd = instruction_in1[25:31];
    rc_addr_odd = instruction_in1[25:31]; // for rt data
  end
end

// -------------- RI7 -----------------------
else if (temp_opcode2 == `op_rothi || temp_opcode2 == `op_roti ||
         temp_opcode2 == `op_shlhi || temp_opcode2 == `op_shli ||
         temp_opcode2 == `op_rotqbyi || temp_opcode2 == `op_rotqbii ||
         temp_opcode2 == `op_shlqbii || temp_opcode2 == `op_shlqbyi) begin

  if (temp_opcode2 == `op_rothi) begin
    instr_id_even = `instr_ID_rothi;
    unit_id_even = 3'd2;
    latency_even = 4'd4;
    reg_wr_even = 1'b1;
    instr2_type = 1'b1;
  end

  else if (temp_opcode2 == `op_roti) begin
    instr_id_even = `instr_ID_roti;
    unit_id_even = 3'd2;
    latency_even = 4'd4;
    reg_wr_even = 1'b1;
    instr2_type = 1'b1;
  end

  else if (temp_opcode2 == `op_shlhi) begin
    instr_id_even = `instr_ID_shlhi;
    unit_id_even = 3'd2;
    latency_even = 4'd4;
    reg_wr_even = 1'b1;
    instr2_type = 1'b1;
  end

  else if (temp_opcode2 == `op_shli) begin
    instr_id_even = `instr_ID_shli;
    unit_id_even = 3'd5;
    latency_even = 4'd4;
    reg_wr_even = 1'b1;
    instr2_type = 1'b1;
  end

  else if (temp_opcode2 == `op_rotqbyi) begin
    instr_id_odd = `instr_ID_rotqbyi; 
    unit_id_odd = 3'd5; 
    latency_odd = 4'd4; 
    reg_wr_odd = 1'b1; 
    instr2_type = 1'b0; 
  end

  else if (temp_opcode2 == `op_rotqbii) begin
    instr_id_odd = `instr_ID_rotqbii; 
    unit_id_odd = 3'd5; 
    latency_odd = 4'd4; 
    reg_wr_odd = 1'b1; 
    instr2_type = 1'b0; 
  end

  else if (temp_opcode2 == `op_shlqbii) begin
    instr_id_odd = `instr_ID_shlqbii; 
    unit_id_odd = 3'd5; 
    latency_odd = 4'd4; 
    reg_wr_odd = 1'b1; 
    instr2_type = 1'b0; 
  end

  else if (temp_opcode2 == `op_shlqbyi) begin
    instr_id_odd = `instr_ID_shlqbyi; 
    unit_id_odd = 3'd5; 
    latency_odd = 4'd4;
    reg_wr_odd = 1'b1; 
    instr2_type = 1'b0; 
  end

  if (instr2_type) begin
    imme7_even = instruction_in2[11:17];
    reg_dst_even = instruction_in2[25:31];
    ra_addr_even = instruction_in2[18:24];
    rc_addr_even = instruction_in2[25:31]; // for rt data
  end else begin
    imme7_odd = instruction_in2[11:17];
    reg_dst_odd = instruction_in2[25:31];
    ra_addr_odd = instruction_in2[18:24];
    rc_addr_odd = instruction_in2[25:31];
  end
end


  // -------------- RR ----------------------
  else if (temp_opcode2 == `op_addx || temp_opcode2 == `op_ah || temp_opcode2 == `op_a || 
            temp_opcode2 == `op_and || temp_opcode2 == `op_bg || temp_opcode2 == `op_bgx ||
            temp_opcode2 == `op_cg || temp_opcode2 == `op_cgx || temp_opcode2 == `op_ceqh ||
            temp_opcode2 == `op_ceq || temp_opcode2 == `op_cgth || temp_opcode2 == `op_cgt ||
            temp_opcode2 == `op_clz || temp_opcode2 == `op_eqv || temp_opcode2 == `op_xor ||
            temp_opcode2 == `op_nand || temp_opcode2 == `op_nor || temp_opcode2 == `op_or ||
            temp_opcode2 == `op_sfx || temp_opcode2 == `op_sfh || temp_opcode2 == `op_sf ||
            temp_opcode2 == `op_roth || temp_opcode2 == `op_rot || temp_opcode2 == `op_shlh ||
            temp_opcode2 == `op_shl || temp_opcode2 == `op_fa || temp_opcode2 == `op_fm ||
            temp_opcode2 == `op_fs || temp_opcode2 == `op_mpy || temp_opcode2 == `op_mpyu ||
            temp_opcode2 == `op_mpyh || temp_opcode2 == `op_cntb || temp_opcode2 == `op_absdb ||
            temp_opcode2 == `op_sumb || temp_opcode2 == `op_avgb || temp_opcode2 == `op_rotqby ||
            temp_opcode2 == `op_rotqbi || temp_opcode2 == `op_shlqbi || temp_opcode2 == `op_shlqby) begin

    if (temp_opcode2 == `op_addx) begin
      instr_id_even = `instr_ID_addx;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr2_type = 1'b1;
    end

    else if (temp_opcode2 == `op_ah) begin
      instr_id_even = `instr_ID_ah;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr2_type = 1'b1;
    end

    else if (temp_opcode2 == `op_a) begin
      instr_id_even = `instr_ID_a;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr2_type = 1'b1;
    end

    else if (temp_opcode2 == `op_and) begin
      instr_id_even = `instr_ID_and;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr2_type = 1'b1;
    end

    else if (temp_opcode2 == `op_bg) begin
      instr_id_even = `instr_ID_bg;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr2_type = 1'b1;
    end

    else if (temp_opcode2 == `op_bgx) begin
      instr_id_even = `instr_ID_bgx; 
      unit_id_even = 3'b001; 
      latency_even = 4'd3; 
      reg_wr_even = 1'b1; 
      instr2_type = 1'b0; 
    end

    else if (temp_opcode2 == `op_cg) begin
      instr_id_even = `instr_ID_cg; 
      unit_id_even = 3'b001; 
      latency_even = 4'd3; 
      reg_wr_even = 1'b0; 
      instr2_type = 1'b0; 
    end

    else if (temp_opcode2 == `op_cgx) begin
      instr_id_even = `instr_ID_cgx;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr2_type = 1'b1;
    end

    else if (temp_opcode2 == `op_ceqh) begin
        instr_id_even = `instr_ID_ceqh;
        unit_id_even = 3'b001;
        latency_even = 4'd3;
        reg_wr_even = 1'b1;
        instr2_type = 1'b1;
    end

    else if (temp_opcode2 == `op_ceq) begin
        instr_id_even = `instr_ID_ceq;
        unit_id_even = 3'b001;
        latency_even = 4'd3;
        reg_wr_even = 1'b1;
        instr2_type = 1'b1;
    end

    else if (temp_opcode2 == `op_cgth) begin
        instr_id_even = `instr_ID_cgth;
        unit_id_even = 3'b001;
        latency_even = 4'd3;
        reg_wr_even = 1'b1;
        instr2_type = 1'b1;
    end

    else if (temp_opcode2 == `op_cgt) begin
        instr_id_even = `instr_ID_cgt; 
        unit_id_even = 3'b001; 
        latency_even = 4'd3; 
        reg_wr_even = 1'b1; 
        instr2_type = 1'b0; 
    end

    else if (temp_opcode2 == `op_clz) begin
      instr_id_even = `instr_ID_clz;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr2_type = 1'b1;
    end

    else if (temp_opcode2 == `op_eqv) begin
      instr_id_even = `instr_ID_eqv;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr2_type = 1'b1;
    end

    else if (temp_opcode2 == `op_xor) begin
      instr_id_even = `instr_ID_xor; 
      unit_id_even = 3'b001; 
      latency_even = 4'd3; 
      reg_wr_even = 1'b0; 
      instr2_type = 1'b0; 
    end

    else if (temp_opcode2 == `op_nand) begin
      instr_id_even = `instr_ID_nand; 
      unit_id_even = 3'b001; 
      latency_even = 4'd3; 
      reg_wr_even = 1'b0; 
      instr2_type = 1'b0; 
    end

    else if (temp_opcode2 == `op_nor) begin
      instr_id_even = `instr_ID_nor; 
      unit_id_even = 3'b001; 
      latency_even = 4'd3; 
      reg_wr_even = 1'b0; 
      instr2_type = 1'b0; 
    end

    else if (temp_opcode2 == `op_or) begin
      instr_id_even = `instr_ID_or; 
      unit_id_even = 3'b001; 
      latency_even = 4'd3; 
      reg_wr_even = 1'b0; 
      instr2_type = 1'b0; 
    end

    else if (temp_opcode2 == `op_sfx) begin
      instr_id_even = `instr_ID_sfx;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr2_type = 1'b1;
    end

    else if (temp_opcode2 == `op_sfh) begin
      instr_id_even = `instr_ID_sfh;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr2_type = 1'b1;
    end

    else if (temp_opcode2 == `op_sf) begin
      instr_id_even = `instr_ID_sf;
      unit_id_even = 3'b001;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr2_type = 1'b1;
    end

    else if (temp_opcode2 == `op_roth) begin
      instr_id_even = `instr_ID_roth;
      unit_id_even = 3'b010;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr2_type = 1'b1;
    end

    else if (temp_opcode2 == `op_rot) begin
      instr_id_even = `instr_ID_rot; 
      unit_id_even = 3'b010; 
      latency_even = 4'd3; 
      reg_wr_even = 1'b1; 
      instr2_type = 1'b1; 
    end

    else if (temp_opcode2 == `op_shlh) begin
      instr_id_even = `instr_ID_shlh;
      unit_id_even = 3'b010;
      latency_even = 4'd3;
      reg_wr_even = 1'b1;
      instr2_type = 1'b1;
  end

    else if (temp_opcode2 == `op_shl) begin
      instr_id_even = `instr_ID_shl; 
      unit_id_even = 3'b010; 
      latency_even = 4'd3; 
      reg_wr_even = 1'b1; 
      instr2_type = 1'b1; 
    end

    else if (temp_opcode2 == `op_fa) begin
      instr_id_even = `instr_ID_fa;
      unit_id_even = 3'b011;
      latency_even = 4'd7;
      reg_wr_even = 1'b1;
      instr2_type = 1'b1;
    end

    else if (temp_opcode2 == `op_fm) begin
      instr_id_even = `instr_ID_fm;
      unit_id_even = 3'b011;
      latency_even = 4'd7;
      reg_wr_even = 1'b1;
      instr2_type = 1'b1;
    end

    else if (temp_opcode2 == `op_fs) begin
      instr_id_even = `instr_ID_fs;
      unit_id_even = 3'b011;
      latency_even = 4'd7;
      reg_wr_even = 1'b1;
      instr2_type = 1'b1;
    end

    else if (temp_opcode2 == `op_mpy) begin
      instr_id_even = `instr_ID_mpy; 
      unit_id_even = 3'b011; 
      latency_even = 4'd8; 
      reg_wr_even = 1'b1; 
      instr2_type = 1'b1; 
    end

    else if (temp_opcode2 == `op_mpyu) begin
      instr_id_even = `instr_ID_mpyu; 
      unit_id_even = 3'b011; 
      latency_even = 4'd8; 
      reg_wr_even = 1'b1; 
      instr2_type = 1'b1; 
    end

    else if (temp_opcode2 == `op_mpyh) begin
      instr_id_even = `instr_ID_mpyh; 
      unit_id_even = 3'b011; 
      latency_even = 4'd8; 
      reg_wr_even = 1'b1; 
      instr2_type = 1'b1;
    end

    else if (temp_opcode2 == `op_cntb) begin
      instr_id_even = `in2str_ID_cntb; 
      unit_id_even = 3'd4; 
      latency_even = 4'd4; 
      reg_wr_even = 1'b1; 
      instr2_type = 1'b1; 
    end

    else if (temp_opcode2 == `op_absdb) begin
      instr_id_even = `instr_ID_absdb; 
      unit_id_even = 3'd4; 
      latency_even = 4'd4; 
      reg_wr_even = 1'b1; 
      instr2_type = 1'b1; 
    end

    else if (temp_opcode2 == `op_sumb) begin
      instr_id_even = `instr_ID_sumb; 
      unit_id_even = 3'd4; 
      latency_even = 4'd4; 
      reg_wr_even = 1'b1; 
      instr2_type = 1'b1; 
    end

    else if (temp_opcode2 == `op_avgb) begin
      instr_id_even = `instr_ID_avgb;
      unit_id_even = 3'd4;
      latency_even = 4'd4;
      reg_wr_even = 1'b1;
      instr2_type = 1'b1;
    end

    else if (temp_opcode2 == `op_rotqby) begin
      instr_id_odd = `instr_ID_rotqby;
      unit_id_odd = 3'd5;
      latency_odd = 4'd4;
      reg_wr_odd = 1'b1;
      instr2_type = 1'b0;
    end

    else if (temp_opcode2 == `op_rotqbi) begin
      instr_id_odd = `instr_ID_rotqbi;
      unit_id_odd = 3'd5;
      latency_odd = 4'd4;
      reg_wr_odd = 1'b1;
      instr2_type = 1'b0;
    end

    else if (temp_opcode2 == `op_shlqbi) begin
      instr_id_odd = `instr_ID_shlqbi;
      unit_id_odd = 3'd5;
      latency_odd = 4'd4;
      reg_wr_odd = 1'b1;
      instr2_type = 1'b0;
    end

    else if (temp_opcode2 == `op_shlqby) begin
      instr_id_odd = `instr_ID_shlqby;
      unit_id_odd = 3'd5;
      latency_odd = 4'd4;
      reg_wr_odd = 1'b1;
      instr2_type = 1'b0;
    end

    if (instr2_type) begin
      reg_dst_even = instruction_in2[25:31];
      ra_addr_even = instruction_in2[18:24];
      rb_addr_even = instruction_in2[11:17];
      rc_addr_even = instruction_in2[25:31]; // for rt data
    end else begin
      reg_dst_odd = instruction_in2[25:31];
      ra_addr_odd = instruction_in2[18:24];
      rb_addr_odd = instruction_in2[11:17];
      rc_addr_odd = instruction_in2[25:31]; // for rt data
    end
  end

end

reg stall;

always @(posedge clk or posedge rst) begin
  if(rst) begin

  end else begin
    if (instr1_type == instr2_type) begin
      stall = 1'b1;
    end
    else if (reg_dst_even == reg_dst_odd) begin
      stall = 1'b1;
    end
    else if ()
    
  end

end

endmodule