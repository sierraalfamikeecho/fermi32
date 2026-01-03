//Arithmetic Logic Unit
module ALU (
  parameter int WIDTH = 32
)(
  input logic [WIDTH-1:0] opA,
  input logic [WIDTH-1:0] opB,

  input logic [3:0] opcode,

  output logic [WIDTH-1:0] result,

  output logic zero,
  output logic negative,
  output logic carry_out,
  output logic overflow
);

//Add
assign sum = opA + opB;

//Subtract
assign dif = opA - opB;

//AND
assign and = opA & opB;

//OR
assign or = opA | opB;

//XOR
assign xor = opA ^ opB;

//Left Shift
assign shiftLeft = opA << opB;

// Right Shift 
assign shiftRight = opA >> opB;

always @(*)
begin
  case (opcode)
    3'b000: result = sum;
    3'b001: result = dif;
    3'b010: result = and;
    3'b011: result = or;
    3'b100: result = xor;
    3'b101: result = shiftLeft;
    3'b111: result = shiftRight;
    default: result = 0;
  endcase
end

assign zero = (result == 0);

assign carry = (sum[WIDTH] != 0);

assign result = result;

endmodule