module program_counter_tb;

//inputs
reg clk;
reg reset;
reg [31:0] pc_in;

//outputs
wire [31:0] pc_out;

program_counter dut (
  .clk(clk),
  .reset(reset),
  .pc_in(pc_in),
  .pc_out(pc_out)
);

// Clockgen
always begin
  clk = 0;
  #5;
  clk = 1;
  #5;
end

//Testbench Stimulus
initial begin
  reset = 1; // Reset is set to high reseting the registers value
  pc_in = 32'h00000000; // Inital value for counter at 0

  //Wait 30 Cycles
  #30;

  // Set reset to low
  reset = 0;

  //Wait another 30 cycles
  #30

  //Change input to test update
  pc_in = 32'h00000004;
  #30

  //End simulation
  $finish;

end

endmodule