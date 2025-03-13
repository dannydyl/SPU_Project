module Reg_file(
  input clk,
  input rst,

  input reg_write_en_1,
  input reg_write_en_2,

  input [0:6] reg_write_addr_1,
  input [0:6] reg_write_addr_2,

  input [0:127] reg_write_data_1,
  input [0:127] reg_write_data_2,

  input [0:6] reg_read_addr_1,
  input [0:6] reg_read_addr_2,
  input [0:6] reg_read_addr_3,
  input [0:6] reg_read_addr_4,
  input [0:6] reg_read_addr_5,
  input [0:6] reg_read_addr_6,

  output [0:127] reg_read_data_1,
  output [0:127] reg_read_data_2,
  output [0:127] reg_read_data_3,
  output [0:127] reg_read_data_4,
  output [0:127] reg_read_data_5,
  output [0:127] reg_read_data_6,

  // Preload inputs for verification purpose only
  input preload_en,
  input [0:127] preload_values [0:127] // Entire register file preload
);
// 128 registers, 128 bit width
reg [0:127] reg_file [0:127];

// read operations (asynchronous)
assign reg_read_data_1 = reg_file[reg_read_addr_1];
assign reg_read_data_2 = reg_file[reg_read_addr_2];
assign reg_read_data_3 = reg_file[reg_read_addr_3];
assign reg_read_data_4 = reg_file[reg_read_addr_4];
assign reg_read_data_5 = reg_file[reg_read_addr_5];
assign reg_read_data_6 = reg_file[reg_read_addr_6];

always @(posedge clk or posedge rst)
  if (preload_en) begin
    // Load all register values at once
    integer i;
    for (i = 0; i < 128; i = i + 1) begin
      reg_file[i] <= preload_values[i];
    end
  end
  else if (rst) begin
    integer i;
    for(i=0;i<128;i=i+1) begin
      reg_file[i] <= 128'b0;
    end
  end
  else begin
    if (reg_write_en_1) begin 
      reg_file[reg_write_addr_1] <= reg_write_data_1;

      // forwarding data if the same register is read and written at the same Clock cycle
      if (reg_write_addr_1 == reg_read_addr_1) reg_read_data_1 <= reg_write_data_1;
      if (reg_write_addr_1 == reg_read_addr_2) reg_read_data_2 <= reg_write_data_1;
      if (reg_write_addr_1 == reg_read_addr_3) reg_read_data_3 <= reg_write_data_1;
      if (reg_write_addr_1 == reg_read_addr_4) reg_read_data_4 <= reg_write_data_1;
      if (reg_write_addr_1 == reg_read_addr_5) reg_read_data_5 <= reg_write_data_1;
      if (reg_write_addr_1 == reg_read_addr_6) reg_read_data_6 <= reg_write_data_1;
    end
    if (reg_write_en_2) begin 
      reg_file[reg_write_addr_2] <= reg_write_data_2;

      // forwarding data if the same register is read and written at the same Clock cycle
      if (reg_write_addr_2 == reg_read_addr_1) reg_read_data_1 <= reg_write_data_2;
      if (reg_write_addr_2 == reg_read_addr_2) reg_read_data_2 <= reg_write_data_2;
      if (reg_write_addr_2 == reg_read_addr_3) reg_read_data_3 <= reg_write_data_2;
      if (reg_write_addr_2 == reg_read_addr_4) reg_read_data_4 <= reg_write_data_2;
      if (reg_write_addr_2 == reg_read_addr_5) reg_read_data_5 <= reg_write_data_2;
      if (reg_write_addr_2 == reg_read_addr_6) reg_read_data_6 <= reg_write_data_2;
    end
  end   

endmodule