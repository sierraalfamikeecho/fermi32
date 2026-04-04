`timescale 1ns/1ps

module register_file(
  input write_enable, clk, rst_n,
  input [4:0] address1,
  input [4:0] address2,
  input [4:0] address3,
  input [31:0] write_data,

  output reg [31:0] read_data1,
  output reg [31:0] read_data2
);

  reg [31:0] registers[31:0];

  always@(posedge clk) begin
      if(rst_n == 1'b0) begin
          for(int i = 0; i<32; i++) begin
              registers[i] <= 32'b0;
          end
      end

      else if(write_enable == 1'b1 && address3 != 0) begin
          registers[address3] <= write_data;
      end
  end
  always@(*) begin
    read_data1 = (address1==1)? registers[address1]:0;
    read_data2 = (address2==1)? registers[address2]:0;
  end

endmodule
