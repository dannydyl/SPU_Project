onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group RegFile /tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/clk
add wave -noupdate -expand -group RegFile /tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/rst
add wave -noupdate -expand -group RegFile /tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_write_en_1
add wave -noupdate -expand -group RegFile /tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_write_en_2
add wave -noupdate -expand -group RegFile /tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_write_addr_1
add wave -noupdate -expand -group RegFile /tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_write_addr_2
add wave -noupdate -expand -group RegFile /tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_write_data_1
add wave -noupdate -expand -group RegFile /tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_write_data_2
add wave -noupdate -expand -group RegFile -radix decimal /tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_read_addr_1
add wave -noupdate -expand -group RegFile -radix decimal /tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_read_addr_2
add wave -noupdate -expand -group RegFile /tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_read_addr_3
add wave -noupdate -expand -group RegFile /tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_read_addr_4
add wave -noupdate -expand -group RegFile /tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_read_addr_5
add wave -noupdate -expand -group RegFile /tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_read_addr_6
add wave -noupdate -expand -group RegFile /tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_read_data_1
add wave -noupdate -expand -group RegFile /tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_read_data_2
add wave -noupdate -expand -group RegFile /tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_read_data_3
add wave -noupdate -expand -group RegFile /tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_read_data_4
add wave -noupdate -expand -group RegFile /tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_read_data_5
add wave -noupdate -expand -group RegFile /tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_read_data_6
add wave -noupdate -expand -group RegFile /tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/preload_en
add wave -noupdate -expand -group RegFile /tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/preload_addr
add wave -noupdate -expand -group RegFile /tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/preload_values
add wave -noupdate -expand -group RegFile /tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/i
add wave -noupdate -expand -group LSMEM /tb_RF_FU_Pipe_wrapper/dut/Odd_Pipe_inst/LSmem_inst/clk
add wave -noupdate -expand -group LSMEM /tb_RF_FU_Pipe_wrapper/dut/Odd_Pipe_inst/LSmem_inst/rst
add wave -noupdate -expand -group LSMEM /tb_RF_FU_Pipe_wrapper/dut/Odd_Pipe_inst/LSmem_inst/LS_write_en
add wave -noupdate -expand -group LSMEM /tb_RF_FU_Pipe_wrapper/dut/Odd_Pipe_inst/LSmem_inst/LS_addr
add wave -noupdate -expand -group LSMEM /tb_RF_FU_Pipe_wrapper/dut/Odd_Pipe_inst/LSmem_inst/LS_data_in
add wave -noupdate -expand -group LSMEM /tb_RF_FU_Pipe_wrapper/dut/Odd_Pipe_inst/LSmem_inst/LS_data_out
add wave -noupdate -expand -group LSMEM /tb_RF_FU_Pipe_wrapper/dut/Odd_Pipe_inst/LSmem_inst/LS_mem
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[0]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[1]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[2]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[3]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[4]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[5]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[6]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[7]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[8]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[9]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[10]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[11]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[12]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[13]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[14]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[15]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[16]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[17]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[18]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[19]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[20]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[21]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[22]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[23]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[24]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[25]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[26]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[27]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[28]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[29]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[30]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[31]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[32]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[33]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[34]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[35]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[36]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[37]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[38]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[39]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[40]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[41]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[42]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[43]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[44]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[45]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[46]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[47]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[48]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[49]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[50]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[51]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[52]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[53]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[54]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[55]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[56]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[57]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[58]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[59]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[60]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[61]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[62]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[63]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[64]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[65]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[66]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[67]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[68]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[69]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[70]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[71]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[72]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[73]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[74]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[75]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[76]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[77]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[78]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[79]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[80]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[81]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[82]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[83]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[84]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[85]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[86]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[87]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[88]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[89]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[90]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[91]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[92]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[93]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[94]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[95]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[96]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[97]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[98]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[99]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[100]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[101]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[102]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[103]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[104]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[105]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[106]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[107]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[108]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[109]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[110]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[111]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[112]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[113]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[114]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[115]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[116]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[117]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[118]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[119]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[120]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[121]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[122]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[123]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[124]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[125]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[126]}
add wave -noupdate -expand -group Registers {/tb_RF_FU_Pipe_wrapper/dut/RF_FU_wrapper_inst/RF_inst/reg_file[127]}
add wave -noupdate -expand -group top_wrapper /tb_RF_FU_Pipe_wrapper/dut/clk
add wave -noupdate -expand -group top_wrapper /tb_RF_FU_Pipe_wrapper/dut/rst
add wave -noupdate -expand -group top_wrapper /tb_RF_FU_Pipe_wrapper/dut/full_instr_even
add wave -noupdate -expand -group top_wrapper /tb_RF_FU_Pipe_wrapper/dut/instr_id_even
add wave -noupdate -expand -group top_wrapper /tb_RF_FU_Pipe_wrapper/dut/reg_dst_even
add wave -noupdate -expand -group top_wrapper /tb_RF_FU_Pipe_wrapper/dut/unit_id_even
add wave -noupdate -expand -group top_wrapper /tb_RF_FU_Pipe_wrapper/dut/latency_even
add wave -noupdate -expand -group top_wrapper /tb_RF_FU_Pipe_wrapper/dut/reg_wr_even
add wave -noupdate -expand -group top_wrapper /tb_RF_FU_Pipe_wrapper/dut/imme7_even
add wave -noupdate -expand -group top_wrapper /tb_RF_FU_Pipe_wrapper/dut/imme10_even
add wave -noupdate -expand -group top_wrapper /tb_RF_FU_Pipe_wrapper/dut/imme16_even
add wave -noupdate -expand -group top_wrapper /tb_RF_FU_Pipe_wrapper/dut/imme18_even
add wave -noupdate -expand -group top_wrapper /tb_RF_FU_Pipe_wrapper/dut/full_instr_odd
add wave -noupdate -expand -group top_wrapper /tb_RF_FU_Pipe_wrapper/dut/instr_id_odd
add wave -noupdate -expand -group top_wrapper /tb_RF_FU_Pipe_wrapper/dut/reg_dst_odd
add wave -noupdate -expand -group top_wrapper /tb_RF_FU_Pipe_wrapper/dut/unit_id_odd
add wave -noupdate -expand -group top_wrapper /tb_RF_FU_Pipe_wrapper/dut/latency_odd
add wave -noupdate -expand -group top_wrapper /tb_RF_FU_Pipe_wrapper/dut/reg_wr_odd
add wave -noupdate -expand -group top_wrapper /tb_RF_FU_Pipe_wrapper/dut/imme7_odd
add wave -noupdate -expand -group top_wrapper /tb_RF_FU_Pipe_wrapper/dut/imme10_odd
add wave -noupdate -expand -group top_wrapper /tb_RF_FU_Pipe_wrapper/dut/imme16_odd
add wave -noupdate -expand -group top_wrapper /tb_RF_FU_Pipe_wrapper/dut/imme18_odd
add wave -noupdate -expand -group top_wrapper /tb_RF_FU_Pipe_wrapper/dut/ra_addr_even
add wave -noupdate -expand -group top_wrapper /tb_RF_FU_Pipe_wrapper/dut/rb_addr_even
add wave -noupdate -expand -group top_wrapper /tb_RF_FU_Pipe_wrapper/dut/rc_addr_even
add wave -noupdate -expand -group top_wrapper /tb_RF_FU_Pipe_wrapper/dut/ra_addr_odd
add wave -noupdate -expand -group top_wrapper /tb_RF_FU_Pipe_wrapper/dut/rb_addr_odd
add wave -noupdate -expand -group top_wrapper /tb_RF_FU_Pipe_wrapper/dut/rc_addr_odd
add wave -noupdate -expand -group top_wrapper /tb_RF_FU_Pipe_wrapper/dut/preload_en
add wave -noupdate -expand -group top_wrapper /tb_RF_FU_Pipe_wrapper/dut/preload_addr
add wave -noupdate -expand -group top_wrapper /tb_RF_FU_Pipe_wrapper/dut/preload_values
add wave -noupdate -expand -group top_wrapper -group Ep /tb_RF_FU_Pipe_wrapper/dut/full_instr_even_to_pipe
add wave -noupdate -expand -group top_wrapper -group Ep /tb_RF_FU_Pipe_wrapper/dut/instr_id_even_to_pipe
add wave -noupdate -expand -group top_wrapper -group Ep /tb_RF_FU_Pipe_wrapper/dut/reg_dst_even_to_pipe
add wave -noupdate -expand -group top_wrapper -group Ep /tb_RF_FU_Pipe_wrapper/dut/unit_id_even_to_pipe
add wave -noupdate -expand -group top_wrapper -group Ep /tb_RF_FU_Pipe_wrapper/dut/latency_even_to_pipe
add wave -noupdate -expand -group top_wrapper -group Ep /tb_RF_FU_Pipe_wrapper/dut/reg_wr_even_to_pipe
add wave -noupdate -expand -group top_wrapper -group Ep /tb_RF_FU_Pipe_wrapper/dut/imme7_even_to_pipe
add wave -noupdate -expand -group top_wrapper -group Ep /tb_RF_FU_Pipe_wrapper/dut/imme10_even_to_pipe
add wave -noupdate -expand -group top_wrapper -group Ep /tb_RF_FU_Pipe_wrapper/dut/imme16_even_to_pipe
add wave -noupdate -expand -group top_wrapper -group Ep /tb_RF_FU_Pipe_wrapper/dut/imme18_even_to_pipe
add wave -noupdate -expand -group top_wrapper -group Ep /tb_RF_FU_Pipe_wrapper/dut/ra_data_even_to_pipe
add wave -noupdate -expand -group top_wrapper -group Ep /tb_RF_FU_Pipe_wrapper/dut/rb_data_even_to_pipe
add wave -noupdate -expand -group top_wrapper -group Ep /tb_RF_FU_Pipe_wrapper/dut/rc_data_even_to_pipe
add wave -noupdate -expand -group top_wrapper -group Ep /tb_RF_FU_Pipe_wrapper/dut/packed_1stage_even
add wave -noupdate -expand -group top_wrapper -group Ep /tb_RF_FU_Pipe_wrapper/dut/packed_2stage_even
add wave -noupdate -expand -group top_wrapper -group Ep /tb_RF_FU_Pipe_wrapper/dut/packed_3stage_even
add wave -noupdate -expand -group top_wrapper -group Ep /tb_RF_FU_Pipe_wrapper/dut/packed_4stage_even
add wave -noupdate -expand -group top_wrapper -group Ep /tb_RF_FU_Pipe_wrapper/dut/packed_5stage_even
add wave -noupdate -expand -group top_wrapper -group Ep /tb_RF_FU_Pipe_wrapper/dut/packed_6stage_even
add wave -noupdate -expand -group top_wrapper -group Ep /tb_RF_FU_Pipe_wrapper/dut/packed_7stage_even
add wave -noupdate -expand -group top_wrapper -group Op /tb_RF_FU_Pipe_wrapper/dut/full_instr_odd_to_pipe
add wave -noupdate -expand -group top_wrapper -group Op /tb_RF_FU_Pipe_wrapper/dut/instr_id_odd_to_pipe
add wave -noupdate -expand -group top_wrapper -group Op /tb_RF_FU_Pipe_wrapper/dut/reg_dst_odd_to_pipe
add wave -noupdate -expand -group top_wrapper -group Op /tb_RF_FU_Pipe_wrapper/dut/unit_id_odd_to_pipe
add wave -noupdate -expand -group top_wrapper -group Op /tb_RF_FU_Pipe_wrapper/dut/latency_odd_to_pipe
add wave -noupdate -expand -group top_wrapper -group Op /tb_RF_FU_Pipe_wrapper/dut/reg_wr_odd_to_pipe
add wave -noupdate -expand -group top_wrapper -group Op /tb_RF_FU_Pipe_wrapper/dut/imme7_odd_to_pipe
add wave -noupdate -expand -group top_wrapper -group Op /tb_RF_FU_Pipe_wrapper/dut/imme10_odd_to_pipe
add wave -noupdate -expand -group top_wrapper -group Op /tb_RF_FU_Pipe_wrapper/dut/imme16_odd_to_pipe
add wave -noupdate -expand -group top_wrapper -group Op /tb_RF_FU_Pipe_wrapper/dut/imme18_odd_to_pipe
add wave -noupdate -expand -group top_wrapper -group Op /tb_RF_FU_Pipe_wrapper/dut/ra_data_odd_to_pipe
add wave -noupdate -expand -group top_wrapper -group Op /tb_RF_FU_Pipe_wrapper/dut/rb_data_odd_to_pipe
add wave -noupdate -expand -group top_wrapper -group Op /tb_RF_FU_Pipe_wrapper/dut/rc_data_odd_to_pipe
add wave -noupdate -expand -group top_wrapper -group Op /tb_RF_FU_Pipe_wrapper/dut/packed_1stage_odd
add wave -noupdate -expand -group top_wrapper -group Op /tb_RF_FU_Pipe_wrapper/dut/packed_2stage_odd
add wave -noupdate -expand -group top_wrapper -group Op /tb_RF_FU_Pipe_wrapper/dut/packed_3stage_odd
add wave -noupdate -expand -group top_wrapper -group Op /tb_RF_FU_Pipe_wrapper/dut/packed_4stage_odd
add wave -noupdate -expand -group top_wrapper -group Op /tb_RF_FU_Pipe_wrapper/dut/packed_5stage_odd
add wave -noupdate -expand -group top_wrapper -group Op /tb_RF_FU_Pipe_wrapper/dut/packed_6stage_odd
add wave -noupdate -expand -group top_wrapper -group Op /tb_RF_FU_Pipe_wrapper/dut/packed_7stage_odd
add wave -noupdate -expand -group top_wrapper /tb_RF_FU_Pipe_wrapper/dut/WB_reg_write_addr_even
add wave -noupdate -expand -group top_wrapper /tb_RF_FU_Pipe_wrapper/dut/WB_reg_write_addr_odd
add wave -noupdate -expand -group top_wrapper /tb_RF_FU_Pipe_wrapper/dut/WB_reg_write_data_even
add wave -noupdate -expand -group top_wrapper /tb_RF_FU_Pipe_wrapper/dut/WB_reg_write_data_odd
add wave -noupdate -expand -group top_wrapper /tb_RF_FU_Pipe_wrapper/dut/WB_reg_write_en_even
add wave -noupdate -expand -group top_wrapper /tb_RF_FU_Pipe_wrapper/dut/WB_reg_write_en_odd
add wave -noupdate -expand -group top_wrapper /tb_RF_FU_Pipe_wrapper/dut/current_PC_odd
add wave -noupdate -expand -group top_wrapper /tb_RF_FU_Pipe_wrapper/dut/new_PC_odd
add wave -noupdate -expand -group EvenPipe /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/clk
add wave -noupdate -expand -group EvenPipe /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/rst
add wave -noupdate -expand -group EvenPipe -color {Lime Green} /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/full_instr
add wave -noupdate -expand -group EvenPipe /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/instr_id
add wave -noupdate -expand -group EvenPipe /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/reg_dst
add wave -noupdate -expand -group EvenPipe /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/unit_id
add wave -noupdate -expand -group EvenPipe /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/latency
add wave -noupdate -expand -group EvenPipe /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/reg_wr
add wave -noupdate -expand -group EvenPipe /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/ra_data
add wave -noupdate -expand -group EvenPipe /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/rb_data
add wave -noupdate -expand -group EvenPipe /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/rc_data
add wave -noupdate -expand -group EvenPipe /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/imme7
add wave -noupdate -expand -group EvenPipe /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/imme10
add wave -noupdate -expand -group EvenPipe /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/imme16
add wave -noupdate -expand -group EvenPipe /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/imme18
add wave -noupdate -expand -group EvenPipe /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/packed_1stage
add wave -noupdate -expand -group EvenPipe /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/packed_2stage
add wave -noupdate -expand -group EvenPipe /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/packed_3stage
add wave -noupdate -expand -group EvenPipe /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/packed_4stage
add wave -noupdate -expand -group EvenPipe /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/packed_5stage
add wave -noupdate -expand -group EvenPipe /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/packed_6stage
add wave -noupdate -expand -group EvenPipe /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/packed_7stage
add wave -noupdate -expand -group EvenPipe /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/WB_reg_write_addr
add wave -noupdate -expand -group EvenPipe /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/WB_reg_write_data
add wave -noupdate -expand -group EvenPipe /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/WB_reg_write_en
add wave -noupdate -expand -group EvenPipe /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/result
add wave -noupdate -expand -group EvenPipe /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/FX1_result
add wave -noupdate -expand -group EvenPipe /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/FX2_result
add wave -noupdate -expand -group EvenPipe /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/SP_result
add wave -noupdate -expand -group EvenPipe /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/BYTE_result
add wave -noupdate -expand -group OddPipe /tb_RF_FU_Pipe_wrapper/dut/Odd_Pipe_inst/clk
add wave -noupdate -expand -group OddPipe /tb_RF_FU_Pipe_wrapper/dut/Odd_Pipe_inst/rst
add wave -noupdate -expand -group OddPipe /tb_RF_FU_Pipe_wrapper/dut/Odd_Pipe_inst/full_instr
add wave -noupdate -expand -group OddPipe /tb_RF_FU_Pipe_wrapper/dut/Odd_Pipe_inst/instr_id
add wave -noupdate -expand -group OddPipe /tb_RF_FU_Pipe_wrapper/dut/Odd_Pipe_inst/reg_dst
add wave -noupdate -expand -group OddPipe /tb_RF_FU_Pipe_wrapper/dut/Odd_Pipe_inst/unit_id
add wave -noupdate -expand -group OddPipe /tb_RF_FU_Pipe_wrapper/dut/Odd_Pipe_inst/latency
add wave -noupdate -expand -group OddPipe /tb_RF_FU_Pipe_wrapper/dut/Odd_Pipe_inst/reg_wr
add wave -noupdate -expand -group OddPipe /tb_RF_FU_Pipe_wrapper/dut/Odd_Pipe_inst/ra_data
add wave -noupdate -expand -group OddPipe /tb_RF_FU_Pipe_wrapper/dut/Odd_Pipe_inst/rb_data
add wave -noupdate -expand -group OddPipe /tb_RF_FU_Pipe_wrapper/dut/Odd_Pipe_inst/rc_data
add wave -noupdate -expand -group OddPipe /tb_RF_FU_Pipe_wrapper/dut/Odd_Pipe_inst/imme7
add wave -noupdate -expand -group OddPipe /tb_RF_FU_Pipe_wrapper/dut/Odd_Pipe_inst/imme10
add wave -noupdate -expand -group OddPipe /tb_RF_FU_Pipe_wrapper/dut/Odd_Pipe_inst/imme16
add wave -noupdate -expand -group OddPipe /tb_RF_FU_Pipe_wrapper/dut/Odd_Pipe_inst/imme18
add wave -noupdate -expand -group OddPipe /tb_RF_FU_Pipe_wrapper/dut/Odd_Pipe_inst/current_PC
add wave -noupdate -expand -group OddPipe /tb_RF_FU_Pipe_wrapper/dut/Odd_Pipe_inst/packed_1stage
add wave -noupdate -expand -group OddPipe /tb_RF_FU_Pipe_wrapper/dut/Odd_Pipe_inst/packed_2stage
add wave -noupdate -expand -group OddPipe /tb_RF_FU_Pipe_wrapper/dut/Odd_Pipe_inst/packed_3stage
add wave -noupdate -expand -group OddPipe /tb_RF_FU_Pipe_wrapper/dut/Odd_Pipe_inst/packed_4stage
add wave -noupdate -expand -group OddPipe /tb_RF_FU_Pipe_wrapper/dut/Odd_Pipe_inst/packed_5stage
add wave -noupdate -expand -group OddPipe /tb_RF_FU_Pipe_wrapper/dut/Odd_Pipe_inst/packed_6stage
add wave -noupdate -expand -group OddPipe /tb_RF_FU_Pipe_wrapper/dut/Odd_Pipe_inst/packed_7stage
add wave -noupdate -expand -group OddPipe /tb_RF_FU_Pipe_wrapper/dut/Odd_Pipe_inst/WB_reg_write_addr
add wave -noupdate -expand -group OddPipe /tb_RF_FU_Pipe_wrapper/dut/Odd_Pipe_inst/WB_reg_write_data
add wave -noupdate -expand -group OddPipe /tb_RF_FU_Pipe_wrapper/dut/Odd_Pipe_inst/WB_reg_write_en
add wave -noupdate -expand -group OddPipe /tb_RF_FU_Pipe_wrapper/dut/Odd_Pipe_inst/new_PC
add wave -noupdate -expand -group OddPipe /tb_RF_FU_Pipe_wrapper/dut/Odd_Pipe_inst/LS_addr
add wave -noupdate -expand -group OddPipe /tb_RF_FU_Pipe_wrapper/dut/Odd_Pipe_inst/PC_result
add wave -noupdate -expand -group OddPipe /tb_RF_FU_Pipe_wrapper/dut/Odd_Pipe_inst/result
add wave -noupdate -expand -group OddPipe /tb_RF_FU_Pipe_wrapper/dut/Odd_Pipe_inst/PERM_result
add wave -noupdate -expand -group OddPipe /tb_RF_FU_Pipe_wrapper/dut/Odd_Pipe_inst/branch_rt_result
add wave -noupdate -expand -group OddPipe /tb_RF_FU_Pipe_wrapper/dut/Odd_Pipe_inst/LS_data_result
add wave -noupdate -expand -group OddPipe /tb_RF_FU_Pipe_wrapper/dut/Odd_Pipe_inst/addr_result
add wave -noupdate -expand -group OddPipe /tb_RF_FU_Pipe_wrapper/dut/Odd_Pipe_inst/LS_write_en
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/instr_id
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/ra_data
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/rb_data
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/rc_data
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/imme7
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/imme10
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/imme16
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/imme18
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/result
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/a_result
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/addx_result
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/ah_result
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/ahi_result
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/ai_result
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/and_result
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/andhi_result
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/andi_result
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/bg_result
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/bgx_result
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/ceq_result
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/ceqh_result
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/ceqi_result
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/ceqhi_result
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/cg_result
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/cgt_result
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/cgth_result
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/cgthi_result
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/cgti_result
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/cgx_result
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/clz_result
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/eqv_result
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/il_result
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/ila_result
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/ilh_result
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/ilhu_result
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/iohl_result
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/nand_result
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/nor_result
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/or_result
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/orhi_result
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/ori_result
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/selb_result
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/sf_result
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/sfh_result
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/sfhi_result
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/sfi_result
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/sfx_result
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/xor_result
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/xorhi_result
add wave -noupdate -group FX1_ALU /tb_RF_FU_Pipe_wrapper/dut/Even_Pipe_inst/fx1_inst/xori_result
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {65000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 502
configure wave -valuecolwidth 100
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
WaveRestoreZoom {20613 ps} {277863 ps}
