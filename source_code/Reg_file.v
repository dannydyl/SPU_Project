module Reg_file(
  input clk,
  input rst,

  input reg_write_en_1,
  input reg_write_en_2,

  input [6:0] reg_write_addr_1,
  input [6:0] reg_write_addr_2,

  input [127:0] reg_write_data_1,
  input [127:0] reg_write_data_2,

  input [6:0] reg_read_addr_1,
  input [6:0] reg_read_addr_2,
  input [6:0] reg_read_addr_3,
  input [6:0] reg_read_addr_4,
  input [6:0] reg_read_addr_5,
  input [6:0] reg_read_addr_6,

  output [127:0] reg_read_data_1,
  output [127:0] reg_read_data_2,
  output [127:0] reg_read_data_3,
  output [127:0] reg_read_data_4,
  output [127:0] reg_read_data_5,
  output [127:0] reg_read_data_6

);
// 128 registers, 128 bit width
reg [127:0] reg_file [127:0];

// read operations (asynchronous)
assign reg_read_data_1 = reg_file[reg_read_addr_1];
assign reg_read_data_2 = reg_file[reg_read_addr_2];
assign reg_read_data_3 = reg_file[reg_read_addr_3];
assign reg_read_data_4 = reg_file[reg_read_addr_4];
assign reg_read_data_5 = reg_file[reg_read_addr_5];
assign reg_read_data_6 = reg_file[reg_read_addr_6];

always @(posedge clk or posedge rst)
  if (rst) begin
    integer i;
    for(i=0;i<128;i=i+1) begin
      reg_file[i] <= 128'b0;
    end
  end
  else begin
    if (reg_write_en_1) reg_file[reg_write_addr_1] <= reg_write_data_1;
    if (reg_write_en_2) reg_file[reg_write_addr_2] <= reg_write_data_2;
  end   

endmodule