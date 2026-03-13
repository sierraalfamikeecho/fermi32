`timescale 1ns/1ps

module cpu (
    input logic clk,
    input logic rst_n
);
//Program Counter Data Path
reg [31:0] program_counter;
logic [31:0] program_counter_next;
logic [31:0] program_counter_second_add;

always_comb begin : program_counter_select
        case (program_counter_source)
                1'b0 : program_counter_next = program_counter + 4;
                1'b1 : program_counter_next = program_counter_second_add;
        endcase
end

always @(posedge clk) begin
    if(rst_n == 0) begin
        program_counter <= 32'b0;
    end else begin
        program_counter <= program_counter_next;
    end
end

//Instruction Memory
wire [31:0] instruction;

memory #(
) instruction_memory (

        .clk(clk),
        .address(program_counter),
        .write_data(32'b0),
        .write_enable(1'b0),
        .reset(1'b1),
        .byte_enable(4'b0000),

        .read_data(instruction)
);

logic [6:0] operation;
assign operation = instruction[6:0];
logic [2:0] f3;
assign f3 = instruction[14:12];
logic [6:0] f7;
assign f7 = instruction[31:25];
wire alu_zero;
wire alu_last_bit;



endmodule
