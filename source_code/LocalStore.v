module LocalStore(
  input clk,
  input rst,
  input LS_write_en,

  input [0:12] LS_addr,
  input [0:127] LS_data_in,

  output [0:127] LS_data_out
);
reg [0:127] LS_mem [0:8191];

assign LS_data_out = LS_mem[LS_addr];

always @(posedge clk or posedge rst) begin
  if (rst) begin
    integer i;
    for(i=0;i<8192;i=i+1) begin
      LS_mem[i] <= 128'b0;
    end
  end
  else begin
    if (LS_write_en) begin 
      LS_mem[LS_addr] <= LS_data_in;
    end
  end
end
endmodule