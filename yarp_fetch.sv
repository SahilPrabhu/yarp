module yarp_instr(
  input logic clk,
  input logic reset,
  input logic[31:0] instr_mem_pc_i,  // input from pc register
  input logic[31:0] mem_rd_data_i, 

  output logic instr_mem_req_o, 
  output logic[31:0] instr_mem_addr_o,  //address of memory holding encoded instruction
  output logic[31:0] instr_mem_instr_o  //32 bit encoded instruction
);

  logic instr_mem_req_q;

  always_ff @(posedge clk or negedge reset)
    if (!reset)
      instr_mem_req_q <= 1'b0; // if triggered by negedge reset set req = 0
    else
      instr_mem_req_q <= 1'b1; /// else enable req pin

  assign instr_mem_req_o  = instr_mem_req_q;
  assign instr_mem_addr_o = instr_mem_pc_i;
  assign instr_mem_instr_o = mem_rd_data_i;
endmodule
