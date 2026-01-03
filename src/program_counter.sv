//A basic program_counter holds address of next instruction
module program_counter(
  input clk,
  input reset,
  input [31:0] pc_in,
  output reg [31:0] pc_out
);

  always@(posedge clk)
  if (reset)
    pc_out<=pc_in;
  else
    pc_out<=pc_in + 4;

endmdoule
