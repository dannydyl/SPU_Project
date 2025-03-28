module LocalStore(
  input clk,
  input rst,
  input LS_write_en,

  input [0:14] LS_addr,
  input [0:127] LS_data_in,

  output reg [0:127] LS_data_out,

  input preload_LS_en,
  input [0:14] preload_LS_addr,
  input [0:127] preload_LS_data
);
reg [0:7] LS_mem [0:32767];


integer i;
  // Asynchronous read
  always @(LS_addr) begin
      for (i = 0; i < 16; i = i + 1) begin
          LS_data_out[i*8 +: 8] = LS_mem[LS_addr + i];
      end
  end


  always @(posedge clk or posedge rst) begin
    if (rst) begin
      if (preload_LS_en) begin
          for (i = 0; i < 16; i = i + 1) begin
            LS_mem[preload_LS_addr + i] <= preload_LS_data[i*8 +: 8];
          end
      end else begin
        for (i = 0; i < 32768; i = i + 1) begin
            LS_mem[i] <= 8'b0;
        end
      end
    end
    else begin
      if (LS_write_en) begin 
        for (i = 0; i < 16; i = i + 1) begin
          LS_mem[LS_addr + i] <= LS_data_in[i*8 +: 8];
        end
      end
    end
  end


endmodule