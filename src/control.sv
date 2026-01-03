//Control Unit

module control (
  input logic [6:0] op,
  input logic [2:0] func3,
  input logic [6:0] func7,
  input logic alu_zero,
  input logic alu_last_bit,
);