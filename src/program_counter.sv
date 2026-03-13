`timescale 1ns/1ps
//A basic program_counter holds address of next instruction
module program_counter (
    input logic clk,
    input logic reset,

    input logic [4:0] address1,
    input logic [4:0] address2,
    output logic [31:0] read_data1,
    output logic [31:0] read_data2,

    input logic write_enable,
    input logic [31:0] write_data,
    input logic [4:0] address2
);

reg [31:0] registers [0:31];

always @(posedge clk) begin
    if(reset == 1'b0) begin
    for (int i = 0; i<32; i++) begin
        registers[i] <= 32'b0;
    end
    end

    else if(write_enable == 1'b1 && address3 != 0) begin
        registers[address3] <= write_data;
    end
end

always_comb begin : readLogic
    read_data1 = registers[address1];
    read_data2 = registers[address2];
end

endmdoule
