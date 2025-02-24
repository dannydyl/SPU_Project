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
`define op_lnop    11'b00000000001  // Load No Operation
`define op_nop     11'b0100000000

`endif