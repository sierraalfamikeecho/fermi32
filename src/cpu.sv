`timescale 1ns / 1ps

module cpu (
    input logic clk,
    input logic rst_n
);
  //Program Counter Data Path
  reg   [31:0] program_counter;
  logic [31:0] program_counter_next;
  logic [31:0] program_counter_second_add;

  always_comb begin : program_counter_select
    case (program_counter_source)
      1'b0: program_counter_next = program_counter + 4;
      1'b1: program_counter_next = program_counter_second_add;
    endcase
  end

  always @(posedge clk) begin
    if (rst_n == 0) begin
      program_counter <= 32'b0;
    end else begin
      program_counter <= program_counter_next;
    end
  end

  //Instruction Memory
  wire [31:0] instruction;

  memory #() instruction_memory (

      .clk(clk),
      .address(program_counter),
      .write_data(32'b0),
      .write_enable(1'b0),
      .reset(1'b1),
      .byte_enable(4'b0000),

      .read_data(instruction)
  );
  //Control
  logic [6:0] operation;
  assign operation = instruction[6:0];
  logic [2:0] f3;
  assign f3 = instruction[14:12];
  logic [6:0] f7;
  assign f7 = instruction[31:25];
  wire alu_zero;
  wire alu_last_bit;

  wire [3:0] alu_control;
  wire [2:0] imm_source;
  wire mem_write;
  wire reg_write;

  wire alu_source;
  wire [1:0] write_back_source;
  wire pc_source;
  wire [1:0] second_add_source;

  control control_unit (
      .op(operation),
      .func3(f3),
      .func7(f7),
      .alu_zero(alu_zero),
      .alu_last_bit(alu_last_bit),

      .alu_control(alu_control),
      .imm_source (imm_source),
      .mem_write  (mem_write),
      .reg_write  (reg_write),

      .alu_control(alu_control),
      .imm_source (imm_source),
      .mem_write  (mem_write),
      .reg_write  (reg_write),

      .alu_source(alu_source),
      .write_back_source(write_back_source),
      .program_counter_source(program_counter_source),
      .second_add_source(second_add_source)
  );

  //Register File
  logic [4:0] source_register1;
  logic [4:0] source_register2;
  logic [4:0] destination_register;
  assign source_register1 = instruction[19:15];
  assign source_register2 = instruction[24:20];
  assign destination_register = instruction[11:7];

  wire [31:0] read_register1;
  wire [31:0] read_register2;

  logic write_back_valid;

  logic [31:0] write_back_data;

  always_comb begin : write_back_source_select
    case (write_back_source)
      2'b00: begin
        write_back_data  = alu_result;
        write_back_valid = 1'b1;
      end
      2'b01: begin
        write_back_data  = mem_read_write_back_data;
        write_back_valid = mem_read_write_back_valid;
      end
      2'b10: begin
        write_back_data  = program_counter_plus_four;
        write_back_valid = 1'b1;
      end
      2'b11: begin
        write_back_data  = program_counter_plus_four;
        write_back_valid = 1'b1;
      end
    endcase
  end

  regfile regfile (
      .clk  (clk),
      .rst_n(rst_n),

      // Read in
      .address1(source_register1),
      .address2(source_register2),

      // Read Out
      .read_data1(read_register1),
      .read_data2(read_register2),

      // Write In
      .write_enable(register_write & write_back_valid),
      .write_data(write_back_data),
      .address3(destination_register)
  );

  //Sign Extend
  logic [24:0] raw_imm;
  assign raw_imm = instruction[31:7];
  wire [31:0] immediate;

  signext sign_extender (
      .raw_src(raw_imm),
      .imm_source(imm_source),
      .immediate(immediate)
  );

  //ALU
  wire  [31:0] alu_result;
  logic [31:0] alu_source2;

  always_comb begin : alu_source_select
    case (alu_source)
      1'b1: alu_source2 = immediate;
      default: alu_source2 = read_register2;
    endcase
  end

  alu alu_instatiate (
      .alu_control(alu_control),
      .src1(read_reg1),
      .src2(alu_src2),
      .alu_result(alu_result),
      .zero(alu_zero),
      .last_bit(alu_last_bit)
  );

  //Load/Store
  wire [ 3:0] memory_byte_enbale;
  wire [31:0] memory_write_data;

  load_store_decoder load_store_decode (
      .alu_result_address(alu_result),
      .reg_read(read_reg2),
      .f3(f3),
      .byte_enable(mem_byte_enable),
      .data(mem_write_data)
  );

  //Data Memory
  wire [31:0] memory_read;

  memory #(
      .memory_init("./test_memory.hex")
  ) data_memory (
      // Memory inputs
      .clk(clk),
      .address({alu_result[31:2], 2'b00}),
      .write_data(mem_write_data),
      .write_enable(mem_write),
      .byte_enable(mem_byte_enable),
      .rst_n(1'b1),

      // Memory outputs
      .read_data(mem_read)
  );

  //Reader
  wire [31:0] memory_write_back_data;
  wire mem_read_write_back_valid;

  reader reader_instance (
      .mem_data(mem_read),
      .be_mask(mem_byte_enable),
      .f3(f3),
      .wb_data(mem_read_write_back_data),
      .valid(mem_read_write_back_valid)
  );

endmodule
