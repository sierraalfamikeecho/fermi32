
module Instruction_Memory;

  reg [31:0] A;

  wire [31:0] IO;

  Instruction_Memory dut (
    .address(A),
    .IO(IO)
  );

  intial begin
    A = 32'h00000000;
    #10;

    A = 32'h00000004;
    #10;

    A = 32'h00000008;
    #10;

    A = 32'h0000000C;
    #10;

    $finish;
  end

endmodule