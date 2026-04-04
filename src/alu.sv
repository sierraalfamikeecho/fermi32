//Arithmetic Logic Unit
`timescale 1ns / 1ps

module alu (
    input logic [WIDTH-1:0] opA,
    input logic [WIDTH-1:0] opB,

    input logic [3:0] opcode,

    output logic [WIDTH-1:0] result,

    output logic zero,
    output logic last_bit
);

  parameter WIDTH = 32;

  always @(*) begin
    case (opcode)
      4'b0000: result = opA + opB;  //Sum
      4'b0001: result = opA - opB;  //Diff
      4'b0010: result = opA & opB;  //And
      4'b0011: result = opA | opB;  //Or
      4'b0100: result = opA ^ opB;  //xor
      4'b0101: result = opA >> opB;  //shift left
      4'b0111: result = opA << opB;  //shift right
      default: result = 0;
    endcase
  end


  assign zero   = (result == 0);

  //assign carry_out = ([WIDTH] != 0);

  assign result = result;
  assign last_bit = result[0];

endmodule
