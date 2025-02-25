module ai(
  input [0:127] ra, 
  input [0:9] imme, 

  output [0:127] result 
);
reg [0:31] s; 
always(*) begin
  // Replicate and sign-extend the immediate value
  s = {{22{imme[0]}}, imme}; // Sign-extend 10-bit immediate to 32-bit
  // 32 - 10 22
  // Compute the result for each 32-bit slot
  result[0:31]   = ra[0:31]   + s; 
  result[32:63]  = ra[32:63]  + s; 
  result[64:95]  = ra[64:95]  + s; 
  result[96:127] = ra[96:127] + s; 
end
endmodule