//Control Unit
`timescale 1ns / 1ps

module control (
    input logic [6:0] op,
    input logic [2:0] func3,
    input logic [6:0] func7,
    input logic alu_zero,
    input logic alu_last_bit,

    output logic [3:0] alu_control,
    output logic [2:0] imm_source,
    output logic memory_write,
    output logic register_write,
    output logic alu_source,
    output logic [1:0] write_back_source,
    output logic program_counter_source,
    output logic [1:0] second_add_source
);

import fermi32_pkg::*;

  // Main Decoder
  logic [1:0] alu_op;
  logic branch;
  logic jump;

  always_latch begin
    case (op)
      OPCODE_I_TYPE_LOAD: begin  //I-Type
        register_write = 1'b1;
        imm_source = 3'b000;
        memory_write = 1'b0;
        alu_op = 2'b00;
        alu_source = 1'b1;
        write_back_source = 2'b01;
        branch = 1'b0;
        jump = 1'b0;
      end
      OPCODE_I_TYPE_ALU: begin  //ALU I-Type
        imm_source = 3'b000;
        alu_source = 1'b1;
        memory_write = 1'b0;
        alu_op = 2'b10;
        write_back_source = 2'b00;
        branch = 1'b0;
        jump = 1'b0;

        if (func3 == F3_SLL) begin
          register_write = (func7 == F7_SLL_SRL | func7 == F7_SRA) ? 1'b1 : 1'b0;
        end else if (func3 == F3_SRL_SRA) begin
          register_write = (func7 == F7_SLL_SRL | func7 == F7_SRA) ? 1'b1 : 1'b0;
        end else begin
          register_write = 1'b1;
        end
      end
      OPCODE_S_TYPE: begin
        register_write = 1'b0;
        imm_source = 3'b001;
        memory_write = 1'b1;
        alu_op = 2'b00;
        alu_source = 1'b1;
        branch = 1'b0;
        jump = 1'b0;
      end
      OPCODE_R_TYPE: begin
        register_write = 1'b1;
        imm_source = 3'b001;
        memory_write = 1'b0;
        alu_op = 2'b10;
        alu_source = 1'b0;
        write_back_source = 2'b00;
        branch = 1'b0;
        jump = 1'b0;
      end
      OPCODE_B_TYPE: begin
        register_write = 1'b0;
        imm_source = 3'b010;
        alu_source = 1'b0;
        memory_write = 1'b0;
        alu_op = 2'b01;
        branch = 1'b1;
        jump = 1'b0;
        second_add_source = 2'b00;
      end
      OPCODE_J_TYPE, OPCODE_J_TYPE_JALR: begin

      end
      OPCODE_U_TYPE_LUI, OPCODE_U_TYPE_AUIPC: begin

      end
      default: begin
        register_write = 1'b0;
        memory_write = 1'b0;
        jump = 1'b0;
        branch = 1'b0;
        $display("ERROR: Invalid OP CODE");
      end
    endcase
  end

  //ALU decoder
  always_comb begin
    case (alu_op)
      //Load & Store
      ALU_OP_LOAD_STORE: alu_control = ALU_SUM;

      ALU_OP_MATH: begin
        case (func3)
          F3_SUM_DIF: begin
            if (op == 7'b110011) begin
              alu_control = (func7 == F7_DIF) ? ALU_SUB : ALU_SUM;
            end else begin
              alu_control = ALU_SUM;
            end
          end

          F3_AND:  alu_control = ALU_AND;
          F3_OR:   alu_control = ALU_OR;
          F3_XOR:  alu_control = ALU_XOR;
          F3_SLT:  alu_control = ALU_SLT;
          F3_SLTU: alu_control = ALU_SLTU;
          F3_SLL:  alu_control = ALU_SLL;
          F3_SRL_SRA: begin
            if (func7 == F7_SLL_SRL) begin
              alu_control = ALU_SRL;
            end else if (func7 == F7_SRA) begin
              alu_control = ALU_SRA;
            end
          end
        endcase
      end
      //Branching
      ALU_OP_BRANCHES: begin
        case (func3)
          F3_BEQ, F3_BNE: alu_control = 4'b0001;
          F3_BLT, F3_BGE: alu_control = 4'b0101;
          F3_BLTU.F3_BGEU: alu_control = 4'b0111;
          default: alu_control = 4'b1111;
        endcase
      end
      default: alu_control = 4'b1111;
    endcase
  end
  //Program Counter source
  logic assert_branch;

  always_comb begin
    case (func3)
      F3_BEQ: assert_branch = alu_zero & branch;
      F3_BLT, F3_BLTU: assert_branch = alu_last_bit & branch;
      // BNE
      F3_BNE: assert_branch = ~alu_zero & branch;
      // BGE, BGEU
      F3_BGE, F3_BGEU: assert_branch = ~alu_last_bit & branch;
      default: assert_branch = 1'b0;
    endcase
  end

  assign program_counter_source = (assert_branch & (op == OPCODE_B_TYPE)) | jump;

endmodule
