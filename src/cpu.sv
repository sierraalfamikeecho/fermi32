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

endmodule
