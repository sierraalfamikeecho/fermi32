module Instruction_Memory(
  input [31:0]address,
  output reg [31:0]IO
);

reg [31:0] mem[63:0];

intial begin
  mem[0] = 32'h00500093;
  mem[1] = 32'h00A00113;
  mem[2] = 32'h002081B3;
  mem[3] = 32'h00300023;
end

always @(*) begin
  IO = mem[address[32:2]];
end

endmodule