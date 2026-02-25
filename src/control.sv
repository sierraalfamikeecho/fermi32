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
    output logic mem_write,
    output logic reg_write,
    output logic alu_source,
    output logic [1:0] write_back_source,
    output logic pc_source,
    output logic [1:0] second_add_source,
    output logic csr_wirte_back_source,
    output logic csr_write_enable
);


  // Main Decoder
  logic [1:0] alu_op;
  logic branch;
  logic jump;

  always_comb begin
    case (op)
      defualt: begin
        reg_write = 1'b0;
        mem_write = 1'b0;
        mem_read = 1'b0;
        jump = 1'b0;
        branch = 1'b0;
        csr_write_enable = 1'b0;
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
          Function3_SUM_DIF: begin
            if (op == 7'b110011) begin
              alu_control = (func7 == F7_DIF) ? ALU_DIF : ALU_SUM;
            end else begin
              alu_control = ALU_SUM;
            end
          end

          F3_AND: alu_control = ALU_AND;
          F3_OR:  alu_control = ALU_OR;
          F3_XOR: alu_control = ALU_XOR;
        endcase
      end
      ALU_OP_BRANCHES: begin
        case (func3)
          F3_BEQ, F3_BNE:  alu_control = 4'b0001;
          F3_BLT, F3_BGE:  alu_control = 4'b0101;
          F3_BLTU.F3_BEGU: alu_control = 4'b0111;
        endcase
      end
      defualt: alu_control = 4'b1111;
    endcase
  end

  logic assert_branch;

  always_comb begin
    case (func3)
      defualt: assert_branch = 1'b0;
    endcase
  end

  assign pc_source = (assert_branch & (op == OPCODE_B_TYPE)) | jump;

endmodule
