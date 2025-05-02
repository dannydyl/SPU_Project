// opcode_package.vh
`ifndef OPCODE_PACKAGE
`define OPCODE_PACKAGE

`define op_addx    11'b01101000000  // Add Extended
`define op_ah      11'b00011001000  // Add Halfword
`define op_ahi     8'b00011101      // Add Halfword Immediate
`define op_a       11'b00011000000  // Add Word
`define op_ai      8'b00011100      // Add Word Immediate
`define op_and     11'b00011000001  // Bitwise And
`define op_andhi   8'b00010101      // And Halfword Immediate
`define op_andi    8'b00010100      // And Immediate
`define op_bg      11'b00001000010  // Borrow Generate
`define op_bgx     11'b01101000011  // Borrow Generate Extended
`define op_cg      11'b00011000010  // Carry Generate
`define op_cgx     11'b01101000010  // Carry Generate Extended
`define op_ceqh    11'b01111001000  // Compare Equal Halfword
`define op_ceqhi   8'b01111101      // Compare Equal Halfword Immediate
`define op_ceq     11'b01111000000  // Compare Equal
`define op_ceqi    8'b01111100      // Compare Equal Immediate
`define op_cgth    11'b01001001000  // Compare Greater Than Halfword
`define op_cgthi   8'b01001101      // Compare Greater Than Halfword Immediate
`define op_cgt     11'b01001000000  // Compare Greater Than
`define op_cgti    8'b01001100      // Compare Greater Than Immediate
`define op_clz     11'b01010100101  // Count Leading Zeros
`define op_eqv     11'b01001001001  // Bitwise Equivalent
`define op_xor     11'b01001000001  // Bitwise XOR
`define op_xorhi   8'b01000101      // XOR Halfword Immediate
`define op_xori    8'b01000100      // XOR Immediate
`define op_ila     7'b0100001       // Immediate Load Address
`define op_ilh     9'b010000011     // Immediate Load Halfword
`define op_ilhu    9'b010000010     // Immediate Load Halfword Upper
`define op_il      9'b010000001     // Immediate Load
`define op_iohl    9'b011000001     // Immediate OR Halfword Lower
`define op_nand    11'b00011001001  // NAND
`define op_nor     11'b00001001001  // NOR
`define op_or      11'b00001000001  // OR
`define op_orhi    8'b00000101      // OR Halfword Immediate
`define op_ori     8'b00000100      // OR Immediate
`define op_selb    4'b1000         // Select Byte
`define op_sfx     11'b01101000001  // Subtract from Extended
`define op_sfh     11'b00001001000  // Subtract from Halfword
`define op_sfhi    8'b00001101      // Subtract from Halfword Immediate
`define op_sf      11'b00001000000  // Subtract from Word
`define op_sfi     8'b00001100      // Subtract from Word Immediate
`define op_roth    11'b00001011100  // Rotate Halfword
`define op_rothi   11'b00001111100  // Rotate Halfword Immediate
`define op_rot     11'b00001011000  // Rotate
`define op_roti    11'b00001111000  // Rotate Immediate
`define op_shlh    11'b00001011111  // Shift Left Halfword
`define op_shlhi   11'b00001111111  // Shift Left Halfword Immediate
`define op_shl     11'b00001011011  // Shift Left
`define op_shli    11'b00001111011  // Shift Left Immediate
`define op_fa      11'b01011000100  // Floating Add
`define op_fm      11'b01011000110  // Floating Multiply
`define op_fma     4'b1110         // Floating Multiply Add
`define op_fms     4'b1111         // Floating Multiply Subtract
`define op_fnms    4'b1101         // Floating Negative Multiply Subtract
`define op_fs      11'b01011000101  // Floating Subtract
`define op_mpy     11'b01111000100  // Multiply
`define op_mpya    4'b1100         // Multiply and Add
`define op_mpyi    8'b01110100      // Multiply Immediate
`define op_mpyu    11'b01111001100  // Multiply Unsigned
`define op_mpyui   8'b01110101      // Multiply Unsigned Immediate
`define op_mpyh    11'b01111000101  // Multiply High
`define op_cntb    11'b01010110100  // Count Bits in Byte
`define op_absdb   11'b00001010011  // Absolute Differences of Bytes
`define op_sumb    11'b01001010011  // Sum Bytes into Halfwords
`define op_avgb    11'b00011010011  // Average Bytes
`define op_rotqbyi 11'b00111111100  // Rotate Quadword by Bytes Immediate
`define op_rotqby  11'b00111011100  // Rotate Quadword by Bytes
`define op_rotqbii 11'b00111111000  // Rotate Quadword Bytes Immediate
`define op_rotqbi  11'b00111011000  // Rotate Quadword Bytes
`define op_shlqbii 11'b00111111011  // Shift Left Quadword Bytes Immediate
`define op_shlqbi  11'b00111011011  // Shift Left Quadword Bytes
`define op_shlqbyi 11'b00111111111  // Shift Left Quadword by Bytes Immediate
`define op_shlqby  11'b00111011111  // Shift Left Quadword by Bytes
`define op_lqd     8'b00110100      // Load Quadword
`define op_lqa     9'b001100001     // Load Quadword Absolute
`define op_stqa    9'b001000001     // Store Quadword Absolute
`define op_stqd    8'b00100100      // Store Quadword
`define op_bra     9'b001100000     // Branch Absolute
`define op_brhnz   9'b001000110     // Branch if Halfword Not Zero
`define op_brz     9'b001000000     // Branch if Zero
`define op_brnz    9'b001000010     // Branch if Not Zero
`define op_brasl   9'b001100010     // Branch Absolute and Set Link
`define op_brsl    9'b001100110     // Branch and Set Link
`define op_br      9'b001100100     // Branch
`define op_brhz    9'b001000100     // Branch if Halfword Zero
`define op_lnop    11'b00000000001  // Load No Operation (for odd)
`define op_nop     11'b01000000001   // No Operation for even
`define op_stop    11'b00000000000  // Stop

`define instr_ID_addx    7'd0
`define instr_ID_ah     7'd1
`define instr_ID_ahi    7'd2
`define instr_ID_a      7'd3
`define instr_ID_ai     7'd4
`define instr_ID_and    7'd5
`define instr_ID_andhi  7'd6
`define instr_ID_andi   7'd7
`define instr_ID_bg     7'd8
`define instr_ID_bgx    7'd9
`define instr_ID_cg     7'd10
`define instr_ID_cgx    7'd11
`define instr_ID_ceqh   7'd12
`define instr_ID_ceqhi  7'd13
`define instr_ID_ceq    7'd14
`define instr_ID_ceqi   7'd15
`define instr_ID_cgth   7'd16
`define instr_ID_cgthi  7'd17
`define instr_ID_cgt    7'd18
`define instr_ID_cgti   7'd19
`define instr_ID_clz    7'd20
`define instr_ID_eqv    7'd21
`define instr_ID_xor    7'd22
`define instr_ID_xorhi  7'd23
`define instr_ID_xori   7'd24
`define instr_ID_ila    7'd25
`define instr_ID_ilh    7'd26
`define instr_ID_ilhu   7'd27
`define instr_ID_il     7'd28
`define instr_ID_iohl   7'd29
`define instr_ID_nand   7'd30
`define instr_ID_nor    7'd31
`define instr_ID_or     7'd32
`define instr_ID_orhi   7'd33
`define instr_ID_ori    7'd34
`define instr_ID_selb   7'd35
`define instr_ID_sfx    7'd36
`define instr_ID_sfh    7'd37
`define instr_ID_sfhi   7'd38
`define instr_ID_sf     7'd39
`define instr_ID_sfi    7'd40 
`define instr_ID_roth   7'd41  // FX2 start
`define instr_ID_rothi  7'd42
`define instr_ID_rot    7'd43
`define instr_ID_roti   7'd44
`define instr_ID_shlh   7'd45
`define instr_ID_shlhi  7'd46
`define instr_ID_shl    7'd47
`define instr_ID_shli   7'd48
`define instr_ID_fa     7'd49  // SP start
`define instr_ID_fm     7'd50
`define instr_ID_fma    7'd51
`define instr_ID_fms    7'd52
`define instr_ID_fnms   7'd53
`define instr_ID_fs     7'd54
`define instr_ID_mpy    7'd55
`define instr_ID_mpya   7'd56
`define instr_ID_mpyi   7'd57
`define instr_ID_mpyu   7'd58
`define instr_ID_mpyui  7'd59
`define instr_ID_mpyh   7'd60
`define instr_ID_cntb   7'd61  // BYTE start
`define instr_ID_absdb  7'd62
`define instr_ID_sumb   7'd63
`define instr_ID_avgb   7'd64
`define instr_ID_rotqbyi 7'd65 // PERMUTE start
`define instr_ID_rotqby  7'd66
`define instr_ID_rotqbii 7'd67
`define instr_ID_rotqbi  7'd68
`define instr_ID_shlqbii 7'd69
`define instr_ID_shlqbi  7'd70
`define instr_ID_shlqbyi 7'd71
`define instr_ID_shlqby  7'd72
`define instr_ID_lqd    7'd73   // LS start
`define instr_ID_lqa    7'd74
`define instr_ID_stqa   7'd75
`define instr_ID_stqd   7'd76
`define instr_ID_bra    7'd77   // BRANCH start
`define instr_ID_brhnz  7'd78
`define instr_ID_brz    7'd79
`define instr_ID_brnz   7'd80
`define instr_ID_brasl  7'd81
`define instr_ID_brsl   7'd82
`define instr_ID_br     7'd83
`define instr_ID_brhz   7'd84
`define instr_ID_lnop   7'd85
`define instr_ID_nop    7'd86
`define instr_ID_stop   7'd87

`endif