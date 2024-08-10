module yarp_regfile(
  input logic clk,

  input logic[4:0] rs1_addr_i; // Adress of source and destination operands as received for decode unit
  input logic[4:0] rs2_addr_i;
  input logic[4:0] rd_addr_i;

  input logic wr_en_i; 
  input logic[31:0] wr_data_i; // Data to be written into destination register

  output logic[31:0] rs1_data_o;
  output logic[31:0] rs2_data_o
);

  logic[31:0] [31:0] regfile;

  for(genvar i=0; i<32; i++) begin : regfile_wr
    logic reg_wr_en;
    assign reg_wr_en = (rd_addr_i == i[4:0]) & wr_en_i; // Checks if the right location is being addressed and write enable is 1
    always_ff @(posedge clk)
      if (i==0)
      begin
        regfile[i] <= 32'h0;  // Since x0 register is hardwired to 0
      end 
      else begin
      	if(reg_wr_en) 
        begin
      	  regfile[i] <= wr_data_i;
	      end
      end
  end
endmodule

