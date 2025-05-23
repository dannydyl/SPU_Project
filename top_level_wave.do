onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group IF /tb_top_level/dut/IF_inst/clk
add wave -noupdate -expand -group IF /tb_top_level/dut/IF_inst/rst
add wave -noupdate -expand -group IF /tb_top_level/dut/IF_inst/load_en
add wave -noupdate -expand -group IF /tb_top_level/dut/IF_inst/instruction_in
add wave -noupdate -expand -group IF /tb_top_level/dut/IF_inst/branch_taken
add wave -noupdate -expand -group IF /tb_top_level/dut/IF_inst/is_branch
add wave -noupdate -expand -group IF /tb_top_level/dut/IF_inst/stall
add wave -noupdate -expand -group IF -radix unsigned /tb_top_level/dut/IF_inst/PC
add wave -noupdate -expand -group IF /tb_top_level/dut/IF_inst/instruction_out1
add wave -noupdate -expand -group IF /tb_top_level/dut/IF_inst/instruction_out2
add wave -noupdate -expand -group IF /tb_top_level/dut/IF_inst/no_more_instruction
add wave -noupdate -expand -group IF /tb_top_level/dut/IF_inst/instr_buffer
add wave -noupdate -expand -group IF -radix unsigned /tb_top_level/dut/IF_inst/PC_br_target
add wave -noupdate -expand -group IF -radix unsigned /tb_top_level/dut/IF_inst/PC_current_out
add wave -noupdate -expand -group IF /tb_top_level/dut/IF_inst/find_nop
add wave -noupdate /tb_top_level/dut/IF_reg_inst/clk
add wave -noupdate /tb_top_level/dut/IF_reg_inst/rst
add wave -noupdate /tb_top_level/dut/IF_reg_inst/PC_in
add wave -noupdate /tb_top_level/dut/IF_reg_inst/instr1_in
add wave -noupdate /tb_top_level/dut/IF_reg_inst/instr2_in
add wave -noupdate /tb_top_level/dut/IF_reg_inst/find_nop_in
add wave -noupdate /tb_top_level/dut/IF_reg_inst/stall
add wave -noupdate /tb_top_level/dut/IF_reg_inst/PC_out
add wave -noupdate /tb_top_level/dut/IF_reg_inst/instr1_out
add wave -noupdate /tb_top_level/dut/IF_reg_inst/instr2_out
add wave -noupdate /tb_top_level/dut/IF_reg_inst/find_nop_out
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/HU_inst/stall
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/HU_inst/dependent_stall
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/HU_inst/flush
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/clk
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/rst
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/is_branch
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/branch_taken
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/PC_pass_in
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/instruction_in1
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/instruction_in2
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/packed_2stage_even
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/packed_3stage_even
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/packed_4stage_even
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/packed_5stage_even
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/packed_6stage_even
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/packed_2stage_odd
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/packed_3stage_odd
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/packed_4stage_odd
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/packed_5stage_odd
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/packed_6stage_odd
add wave -noupdate -expand -group ID -radix unsigned /tb_top_level/dut/IDHU_inst/instr_id_even
add wave -noupdate -expand -group ID -radix unsigned /tb_top_level/dut/IDHU_inst/reg_dst_even
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/unit_id_even
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/latency_even
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/reg_wr_even
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/imme7_even
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/imme10_even
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/imme16_even
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/imme18_even
add wave -noupdate -expand -group ID -radix unsigned /tb_top_level/dut/IDHU_inst/ra_addr_even
add wave -noupdate -expand -group ID -radix unsigned /tb_top_level/dut/IDHU_inst/rb_addr_even
add wave -noupdate -expand -group ID -radix unsigned /tb_top_level/dut/IDHU_inst/rc_addr_even
add wave -noupdate -expand -group ID -radix unsigned /tb_top_level/dut/IDHU_inst/instr_id_odd
add wave -noupdate -expand -group ID -radix unsigned /tb_top_level/dut/IDHU_inst/reg_dst_odd
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/unit_id_odd
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/latency_odd
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/reg_wr_odd
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/imme7_odd
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/imme10_odd
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/imme16_odd
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/imme18_odd
add wave -noupdate -expand -group ID -radix unsigned /tb_top_level/dut/IDHU_inst/ra_addr_odd
add wave -noupdate -expand -group ID -radix unsigned /tb_top_level/dut/IDHU_inst/rb_addr_odd
add wave -noupdate -expand -group ID -radix unsigned /tb_top_level/dut/IDHU_inst/rc_addr_odd
add wave -noupdate -expand -group ID -radix unsigned /tb_top_level/dut/IDHU_inst/temp_instr_id_1
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/temp_reg_dst_1
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/temp_unit_id_1
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/temp_latency_1
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/temp_reg_wr_1
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/temp_ra_addr_1
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/temp_rb_addr_1
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/temp_rc_addr_1
add wave -noupdate -expand -group ID -radix unsigned /tb_top_level/dut/IDHU_inst/temp_instr_id_2
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/temp_reg_dst_2
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/temp_unit_id_2
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/temp_latency_2
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/temp_reg_wr_2
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/temp_ra_addr_2
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/temp_rb_addr_2
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/temp_rc_addr_2
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/temp_stall
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/temp_dependent_stall
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/temp_flush
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/temp_instr1_type
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/temp_instr2_type
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/instr_dependent_protocol
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/data_dependent_protocol
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/stall
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/temp_dependent_stall
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/instr_dependent_protocol
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/data_dependent_protocol
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/flush
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/PC_pass_out
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/temp_stall
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/temp_flush
add wave -noupdate -expand -group ID /tb_top_level/dut/IDHU_inst/HU_inst/instr_dependent_protocol
add wave -noupdate -expand -group HU /tb_top_level/dut/IDHU_inst/HU_inst/instr_dependent_protocol
add wave -noupdate -expand -group HU /tb_top_level/dut/IDHU_inst/HU_inst/instr1_type
add wave -noupdate -expand -group HU /tb_top_level/dut/IDHU_inst/HU_inst/instr2_type
add wave -noupdate -expand -group HU /tb_top_level/dut/IDHU_inst/HU_inst/instr_same
add wave -noupdate -expand -group HU /tb_top_level/dut/IDHU_inst/HU_inst/is_branch
add wave -noupdate -expand -group HU /tb_top_level/dut/IDHU_inst/HU_inst/branch_taken
add wave -noupdate -expand -group HU /tb_top_level/dut/IDHU_inst/HU_inst/reg_dst_even
add wave -noupdate -expand -group HU /tb_top_level/dut/IDHU_inst/HU_inst/ra_addr_even
add wave -noupdate -expand -group HU /tb_top_level/dut/IDHU_inst/HU_inst/rb_addr_even
add wave -noupdate -expand -group HU /tb_top_level/dut/IDHU_inst/HU_inst/rc_addr_even
add wave -noupdate -expand -group HU /tb_top_level/dut/IDHU_inst/HU_inst/reg_dst_odd
add wave -noupdate -expand -group HU /tb_top_level/dut/IDHU_inst/HU_inst/ra_addr_odd
add wave -noupdate -expand -group HU /tb_top_level/dut/IDHU_inst/HU_inst/rb_addr_odd
add wave -noupdate -expand -group HU /tb_top_level/dut/IDHU_inst/HU_inst/rc_addr_odd
add wave -noupdate -expand -group HU /tb_top_level/dut/IDHU_inst/HU_inst/ID_reg_dst_even
add wave -noupdate -expand -group HU /tb_top_level/dut/IDHU_inst/HU_inst/ID_reg_wr_even
add wave -noupdate -expand -group HU /tb_top_level/dut/IDHU_inst/HU_inst/RF_reg_dst_even
add wave -noupdate -expand -group HU /tb_top_level/dut/IDHU_inst/HU_inst/RF_reg_wr_even
add wave -noupdate -expand -group HU /tb_top_level/dut/IDHU_inst/HU_inst/RF_latency_even
add wave -noupdate -expand -group HU /tb_top_level/dut/IDHU_inst/HU_inst/packed_2stage_even
add wave -noupdate -expand -group HU /tb_top_level/dut/IDHU_inst/HU_inst/packed_3stage_even
add wave -noupdate -expand -group HU /tb_top_level/dut/IDHU_inst/HU_inst/packed_4stage_even
add wave -noupdate -expand -group HU /tb_top_level/dut/IDHU_inst/HU_inst/packed_5stage_even
add wave -noupdate -expand -group HU /tb_top_level/dut/IDHU_inst/HU_inst/packed_6stage_even
add wave -noupdate -expand -group HU /tb_top_level/dut/IDHU_inst/HU_inst/ID_reg_dst_odd
add wave -noupdate -expand -group HU /tb_top_level/dut/IDHU_inst/HU_inst/ID_reg_wr_odd
add wave -noupdate -expand -group HU /tb_top_level/dut/IDHU_inst/HU_inst/RF_reg_dst_odd
add wave -noupdate -expand -group HU /tb_top_level/dut/IDHU_inst/HU_inst/RF_reg_wr_odd
add wave -noupdate -expand -group HU /tb_top_level/dut/IDHU_inst/HU_inst/RF_latency_odd
add wave -noupdate -expand -group HU /tb_top_level/dut/IDHU_inst/HU_inst/packed_2stage_odd
add wave -noupdate -expand -group HU /tb_top_level/dut/IDHU_inst/HU_inst/packed_3stage_odd
add wave -noupdate -expand -group HU /tb_top_level/dut/IDHU_inst/HU_inst/packed_4stage_odd
add wave -noupdate -expand -group HU /tb_top_level/dut/IDHU_inst/HU_inst/packed_5stage_odd
add wave -noupdate -expand -group HU /tb_top_level/dut/IDHU_inst/HU_inst/packed_6stage_odd
add wave -noupdate -expand -group HU /tb_top_level/dut/IDHU_inst/HU_inst/stall
add wave -noupdate -expand -group HU /tb_top_level/dut/IDHU_inst/HU_inst/dependent_stall
add wave -noupdate -expand -group HU /tb_top_level/dut/IDHU_inst/HU_inst/flush
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/clk
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/rst
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/flush
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/PC_pass_in
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/instr_id_even
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/reg_dst_even
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/unit_id_even
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/latency_even
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/reg_wr_even
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/imme7_even
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/imme10_even
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/imme16_even
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/imme18_even
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/instr_id_odd
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/reg_dst_odd
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/unit_id_odd
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/latency_odd
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/reg_wr_odd
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/imme7_odd
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/imme10_odd
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/imme16_odd
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/imme18_odd
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/ra_addr_even
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/rb_addr_even
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/rc_addr_even
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/ra_addr_odd
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/rb_addr_odd
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/rc_addr_odd
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/reg_write_en_1
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/reg_write_en_2
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/reg_write_addr_1
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/reg_write_addr_2
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/reg_write_data_1
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/reg_write_data_2
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/out_instr_id_even
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/out_reg_dst_even
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/out_unit_id_even
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/out_latency_even
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/out_reg_wr_even
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/out_imme7_even
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/out_imme10_even
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/out_imme16_even
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/out_imme18_even
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/out_instr_id_odd
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/out_reg_dst_odd
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/out_unit_id_odd
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/out_latency_odd
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/out_reg_wr_odd
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/out_imme7_odd
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/out_imme10_odd
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/out_imme16_odd
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/out_imme18_odd
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/ra_data_even
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/rb_data_even
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/rc_data_even
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/ra_data_odd
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/rb_data_odd
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/rc_data_odd
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/PC_pass_out
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/preload_en
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/preload_addr
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/preload_values
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/regfile_out_data_1
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/regfile_out_data_2
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/regfile_out_data_3
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/regfile_out_data_4
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/regfile_out_data_5
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/regfile_out_data_6
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/ra_fw_en_2stage_even
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rb_fw_en_2stage_even
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rc_fw_en_2stage_even
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/ra_fw_en_3stage_even
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rb_fw_en_3stage_even
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rc_fw_en_3stage_even
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/ra_fw_en_4stage_even
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rb_fw_en_4stage_even
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rc_fw_en_4stage_even
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/ra_fw_en_5stage_even
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rb_fw_en_5stage_even
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rc_fw_en_5stage_even
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/ra_fw_en_6stage_even
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rb_fw_en_6stage_even
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rc_fw_en_6stage_even
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/ra_fw_en_7stage_even
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rb_fw_en_7stage_even
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rc_fw_en_7stage_even
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/ra_fw_en_2stage_odd
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rb_fw_en_2stage_odd
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rc_fw_en_2stage_odd
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/ra_fw_en_3stage_odd
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rb_fw_en_3stage_odd
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rc_fw_en_3stage_odd
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/ra_fw_en_4stage_odd
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rb_fw_en_4stage_odd
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rc_fw_en_4stage_odd
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/ra_fw_en_5stage_odd
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rb_fw_en_5stage_odd
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rc_fw_en_5stage_odd
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/ra_fw_en_6stage_odd
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rb_fw_en_6stage_odd
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rc_fw_en_6stage_odd
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/ra_fw_en_7stage_odd
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rb_fw_en_7stage_odd
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rc_fw_en_7stage_odd
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/ra_fw_en_2stage_from_odd_to_even
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rb_fw_en_2stage_from_odd_to_even
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rc_fw_en_2stage_from_odd_to_even
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/ra_fw_en_3stage_from_odd_to_even
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rb_fw_en_3stage_from_odd_to_even
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rc_fw_en_3stage_from_odd_to_even
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/ra_fw_en_4stage_from_odd_to_even
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rb_fw_en_4stage_from_odd_to_even
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rc_fw_en_4stage_from_odd_to_even
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/ra_fw_en_5stage_from_odd_to_even
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rb_fw_en_5stage_from_odd_to_even
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rc_fw_en_5stage_from_odd_to_even
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/ra_fw_en_6stage_from_odd_to_even
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rb_fw_en_6stage_from_odd_to_even
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rc_fw_en_6stage_from_odd_to_even
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/ra_fw_en_7stage_from_odd_to_even
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rb_fw_en_7stage_from_odd_to_even
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rc_fw_en_7stage_from_odd_to_even
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/ra_fw_en_2stage_from_even_to_odd
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rb_fw_en_2stage_from_even_to_odd
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rc_fw_en_2stage_from_even_to_odd
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/ra_fw_en_3stage_from_even_to_odd
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rb_fw_en_3stage_from_even_to_odd
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rc_fw_en_3stage_from_even_to_odd
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/ra_fw_en_4stage_from_even_to_odd
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rb_fw_en_4stage_from_even_to_odd
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rc_fw_en_4stage_from_even_to_odd
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/ra_fw_en_5stage_from_even_to_odd
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rb_fw_en_5stage_from_even_to_odd
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rc_fw_en_5stage_from_even_to_odd
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/ra_fw_en_6stage_from_even_to_odd
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rb_fw_en_6stage_from_even_to_odd
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rc_fw_en_6stage_from_even_to_odd
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/ra_fw_en_7stage_from_even_to_odd
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rb_fw_en_7stage_from_even_to_odd
add wave -noupdate -expand -group RF -group forwarding_signal /tb_top_level/dut/RFFU_inst/rc_fw_en_7stage_from_even_to_odd
add wave -noupdate -expand -group RF /tb_top_level/dut/RFFU_inst/RF_inst/reg_file
add wave -noupdate -expand -group EvenPipe /tb_top_level/dut/Even_Pipe_inst/clk
add wave -noupdate -expand -group EvenPipe /tb_top_level/dut/Even_Pipe_inst/rst
add wave -noupdate -expand -group EvenPipe /tb_top_level/dut/Even_Pipe_inst/flush
add wave -noupdate -expand -group EvenPipe /tb_top_level/dut/Even_Pipe_inst/instr_id
add wave -noupdate -expand -group EvenPipe /tb_top_level/dut/Even_Pipe_inst/reg_dst
add wave -noupdate -expand -group EvenPipe /tb_top_level/dut/Even_Pipe_inst/unit_id
add wave -noupdate -expand -group EvenPipe /tb_top_level/dut/Even_Pipe_inst/latency
add wave -noupdate -expand -group EvenPipe /tb_top_level/dut/Even_Pipe_inst/reg_wr
add wave -noupdate -expand -group EvenPipe /tb_top_level/dut/Even_Pipe_inst/ra_data
add wave -noupdate -expand -group EvenPipe /tb_top_level/dut/Even_Pipe_inst/rb_data
add wave -noupdate -expand -group EvenPipe /tb_top_level/dut/Even_Pipe_inst/rc_data
add wave -noupdate -expand -group EvenPipe /tb_top_level/dut/Even_Pipe_inst/imme7
add wave -noupdate -expand -group EvenPipe /tb_top_level/dut/Even_Pipe_inst/imme10
add wave -noupdate -expand -group EvenPipe /tb_top_level/dut/Even_Pipe_inst/imme16
add wave -noupdate -expand -group EvenPipe /tb_top_level/dut/Even_Pipe_inst/imme18
add wave -noupdate -expand -group EvenPipe /tb_top_level/dut/Even_Pipe_inst/packed_1stage
add wave -noupdate -expand -group EvenPipe /tb_top_level/dut/Even_Pipe_inst/packed_2stage
add wave -noupdate -expand -group EvenPipe /tb_top_level/dut/Even_Pipe_inst/packed_3stage
add wave -noupdate -expand -group EvenPipe /tb_top_level/dut/Even_Pipe_inst/packed_4stage
add wave -noupdate -expand -group EvenPipe /tb_top_level/dut/Even_Pipe_inst/packed_5stage
add wave -noupdate -expand -group EvenPipe /tb_top_level/dut/Even_Pipe_inst/packed_6stage
add wave -noupdate -expand -group EvenPipe /tb_top_level/dut/Even_Pipe_inst/packed_7stage
add wave -noupdate -expand -group EvenPipe /tb_top_level/dut/Even_Pipe_inst/WB_reg_write_addr
add wave -noupdate -expand -group EvenPipe /tb_top_level/dut/Even_Pipe_inst/WB_reg_write_data
add wave -noupdate -expand -group EvenPipe /tb_top_level/dut/Even_Pipe_inst/WB_reg_write_en
add wave -noupdate -expand -group EvenPipe /tb_top_level/dut/Even_Pipe_inst/result
add wave -noupdate -expand -group EvenPipe /tb_top_level/dut/Even_Pipe_inst/FX1_result
add wave -noupdate -expand -group EvenPipe /tb_top_level/dut/Even_Pipe_inst/FX2_result
add wave -noupdate -expand -group EvenPipe /tb_top_level/dut/Even_Pipe_inst/SP_result
add wave -noupdate -expand -group EvenPipe /tb_top_level/dut/Even_Pipe_inst/BYTE_result
add wave -noupdate -expand -group OddPipe /tb_top_level/dut/Odd_Pipe_inst/clk
add wave -noupdate -expand -group OddPipe /tb_top_level/dut/Odd_Pipe_inst/rst
add wave -noupdate -expand -group OddPipe /tb_top_level/dut/Odd_Pipe_inst/flush
add wave -noupdate -expand -group OddPipe -radix unsigned /tb_top_level/dut/Odd_Pipe_inst/instr_id
add wave -noupdate -expand -group OddPipe /tb_top_level/dut/Odd_Pipe_inst/reg_dst
add wave -noupdate -expand -group OddPipe -radix unsigned /tb_top_level/dut/Odd_Pipe_inst/unit_id
add wave -noupdate -expand -group OddPipe /tb_top_level/dut/Odd_Pipe_inst/latency
add wave -noupdate -expand -group OddPipe /tb_top_level/dut/Odd_Pipe_inst/reg_wr
add wave -noupdate -expand -group OddPipe /tb_top_level/dut/Odd_Pipe_inst/ra_data
add wave -noupdate -expand -group OddPipe /tb_top_level/dut/Odd_Pipe_inst/rb_data
add wave -noupdate -expand -group OddPipe /tb_top_level/dut/Odd_Pipe_inst/rc_data
add wave -noupdate -expand -group OddPipe /tb_top_level/dut/Odd_Pipe_inst/imme7
add wave -noupdate -expand -group OddPipe /tb_top_level/dut/Odd_Pipe_inst/imme10
add wave -noupdate -expand -group OddPipe /tb_top_level/dut/Odd_Pipe_inst/imme16
add wave -noupdate -expand -group OddPipe /tb_top_level/dut/Odd_Pipe_inst/imme18
add wave -noupdate -expand -group OddPipe /tb_top_level/dut/Odd_Pipe_inst/current_PC
add wave -noupdate -expand -group OddPipe /tb_top_level/dut/Odd_Pipe_inst/packed_1stage
add wave -noupdate -expand -group OddPipe /tb_top_level/dut/Odd_Pipe_inst/packed_2stage
add wave -noupdate -expand -group OddPipe /tb_top_level/dut/Odd_Pipe_inst/packed_3stage
add wave -noupdate -expand -group OddPipe /tb_top_level/dut/Odd_Pipe_inst/packed_4stage
add wave -noupdate -expand -group OddPipe /tb_top_level/dut/Odd_Pipe_inst/packed_5stage
add wave -noupdate -expand -group OddPipe /tb_top_level/dut/Odd_Pipe_inst/packed_6stage
add wave -noupdate -expand -group OddPipe /tb_top_level/dut/Odd_Pipe_inst/packed_7stage
add wave -noupdate -expand -group OddPipe /tb_top_level/dut/Odd_Pipe_inst/WB_reg_write_addr
add wave -noupdate -expand -group OddPipe /tb_top_level/dut/Odd_Pipe_inst/WB_reg_write_data
add wave -noupdate -expand -group OddPipe /tb_top_level/dut/Odd_Pipe_inst/WB_reg_write_en
add wave -noupdate -expand -group OddPipe /tb_top_level/dut/Odd_Pipe_inst/new_PC
add wave -noupdate -expand -group OddPipe /tb_top_level/dut/Odd_Pipe_inst/branch_taken
add wave -noupdate -expand -group OddPipe /tb_top_level/dut/Odd_Pipe_inst/is_branch
add wave -noupdate -expand -group OddPipe /tb_top_level/dut/Odd_Pipe_inst/preload_LS_en
add wave -noupdate -expand -group OddPipe /tb_top_level/dut/Odd_Pipe_inst/preload_LS_addr
add wave -noupdate -expand -group OddPipe /tb_top_level/dut/Odd_Pipe_inst/preload_LS_data
add wave -noupdate -expand -group OddPipe /tb_top_level/dut/Odd_Pipe_inst/new_PC_result
add wave -noupdate -expand -group OddPipe /tb_top_level/dut/Odd_Pipe_inst/result
add wave -noupdate -expand -group OddPipe /tb_top_level/dut/Odd_Pipe_inst/PERM_result
add wave -noupdate -expand -group OddPipe /tb_top_level/dut/Odd_Pipe_inst/branch_rt_result
add wave -noupdate -expand -group OddPipe /tb_top_level/dut/Odd_Pipe_inst/LS_data_result
add wave -noupdate -expand -group OddPipe /tb_top_level/dut/Odd_Pipe_inst/addr_result
add wave -noupdate -expand -group OddPipe /tb_top_level/dut/Odd_Pipe_inst/LS_write_en
add wave -noupdate -expand -group OddPipe /tb_top_level/dut/Odd_Pipe_inst/BRANCH_inst/branch_taken
add wave -noupdate -expand -group OddPipe /tb_top_level/dut/Odd_Pipe_inst/branch_taken_1stage
add wave -noupdate -radix unsigned /tb_top_level/dut/Odd_Pipe_inst/BRANCH_inst/brz_inst/imme16
add wave -noupdate /tb_top_level/dut/Odd_Pipe_inst/BRANCH_inst/brz_inst/rt
add wave -noupdate -radix unsigned /tb_top_level/dut/Odd_Pipe_inst/BRANCH_inst/brz_inst/in_PC
add wave -noupdate -radix unsigned /tb_top_level/dut/Odd_Pipe_inst/BRANCH_inst/brz_inst/PC_result
add wave -noupdate /tb_top_level/dut/Odd_Pipe_inst/BRANCH_inst/brz_inst/branch_taken
add wave -noupdate -expand -group LSmem /tb_top_level/dut/Odd_Pipe_inst/LSmem_inst/clk
add wave -noupdate -expand -group LSmem /tb_top_level/dut/Odd_Pipe_inst/LSmem_inst/rst
add wave -noupdate -expand -group LSmem /tb_top_level/dut/Odd_Pipe_inst/LSmem_inst/LS_write_en
add wave -noupdate -expand -group LSmem -radix binary /tb_top_level/dut/Odd_Pipe_inst/LSmem_inst/LS_addr
add wave -noupdate -expand -group LSmem /tb_top_level/dut/Odd_Pipe_inst/LSmem_inst/LS_data_in
add wave -noupdate -expand -group LSmem /tb_top_level/dut/Odd_Pipe_inst/LSmem_inst/LS_data_out
add wave -noupdate -expand -group LSmem -expand /tb_top_level/dut/Odd_Pipe_inst/LSmem_inst/LS_mem
add wave -noupdate -expand -group LSmem /tb_top_level/dut/Odd_Pipe_inst/LSmem_inst/preload_LS_en
add wave -noupdate -expand -group LSmem /tb_top_level/dut/Odd_Pipe_inst/LSmem_inst/preload_LS_addr
add wave -noupdate -expand -group LSmem /tb_top_level/dut/Odd_Pipe_inst/LSmem_inst/preload_LS_data
add wave -noupdate -expand -group LSmem /tb_top_level/dut/Odd_Pipe_inst/LSmem_inst/i
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/clk
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/IF_inst/instruction_out1
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/IF_inst/instruction_out2
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/IDHU_inst/instr_id_even
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/IDHU_inst/reg_dst_even
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/IDHU_inst/unit_id_even
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/IDHU_inst/latency_even
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/IDHU_inst/reg_wr_even
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/IDHU_inst/imme7_even
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/IDHU_inst/imme10_even
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/IDHU_inst/imme16_even
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/IDHU_inst/imme18_even
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/IDHU_inst/ra_addr_even
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/IDHU_inst/rb_addr_even
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/IDHU_inst/rc_addr_even
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/IDHU_inst/instr_id_odd
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/IDHU_inst/reg_dst_odd
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/IDHU_inst/unit_id_odd
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/IDHU_inst/latency_odd
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/IDHU_inst/reg_wr_odd
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/IDHU_inst/imme7_odd
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/IDHU_inst/imme10_odd
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/IDHU_inst/imme16_odd
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/IDHU_inst/imme18_odd
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/IDHU_inst/ra_addr_odd
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/IDHU_inst/rb_addr_odd
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/IDHU_inst/rc_addr_odd
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/RFFU_inst/ra_data_even
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/RFFU_inst/rb_data_even
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/RFFU_inst/rc_data_even
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/RFFU_inst/ra_data_odd
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/RFFU_inst/rb_data_odd
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/RFFU_inst/rc_data_odd
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/RFFU_inst/reg_write_en_1
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/RFFU_inst/reg_write_en_2
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/RFFU_inst/reg_write_addr_1
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/RFFU_inst/reg_write_addr_2
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/RFFU_inst/reg_write_data_1
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/RFFU_inst/reg_write_data_2
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/RFFU_inst/RF_inst/reg_file
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/Even_Pipe_inst/packed_1stage
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/Even_Pipe_inst/packed_2stage
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/Even_Pipe_inst/packed_3stage
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/Even_Pipe_inst/packed_4stage
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/Even_Pipe_inst/packed_5stage
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/Even_Pipe_inst/packed_6stage
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/Even_Pipe_inst/packed_7stage
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/Odd_Pipe_inst/packed_1stage
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/Odd_Pipe_inst/packed_2stage
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/Odd_Pipe_inst/packed_3stage
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/Odd_Pipe_inst/packed_4stage
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/Odd_Pipe_inst/packed_5stage
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/Odd_Pipe_inst/packed_6stage
add wave -noupdate -group Full_pipe_demo /tb_top_level/dut/Odd_Pipe_inst/packed_7stage
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1762180 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 362
configure wave -valuecolwidth 81
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {488700 ps}
