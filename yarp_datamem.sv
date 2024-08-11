module yarp_data_mem import yarp_pkg::*; (
  input   logic           clk,
  input   logic           reset,

  input   logic           data_req_i,
  input   logic [31:0]    data_addr_i,
  input   logic [1:0]     data_byte_en_i,
  input   logic           data_wr_i,
  input   logic [31:0]    data_wr_data_i,

  input   logic           data_zero_extnd_i,

  output  logic           data_mem_req_o,
  output  logic [31:0]    data_mem_addr_o,
  output  logic [1:0]     data_mem_byte_en_o,
  output  logic           data_mem_wr_o,
  output  logic [31:0]	  data_mem_wr_data_o,

  input   logic [31:0]    mem_rd_data_i,

  output  logic [31:0]    data_mem_rd_data_o
);

    logic [31:0] data_mem_rd_data;
    logic [31:0] rd_data_sign_extnd;
    logic [31:0] rd_data_zero_extnd;
  
    assign rd_data_sign_extnd = (data_byte_en_i == HALF_WORD) ? {{16{mem_rd_data_i[15]}},mem_rd_data_i[15:0]}:
	    			(data_byte_en_i == BYTE)      ? {{24{mem_rd_data_i[7]}}, mem_rd_data_i[7:0]}:
    		        							         mem_rd_data_i;
  														
    assign rd_data_zero_extnd = (data_byte_en_i == HALF_WORD) ? {{16{1'b0}},mem_rd_data_i[15:0]}:
	    			(data_byte_en_i == BYTE)      ? {{24{1'b0}},mem_rd_data_i[7:0]}:
    							  		    mem_rd_data_i;

    assign data_mem_rd_data =  data_zero_extnd_i ? rd_data_zero_extnd : rd_data_sign_extnd;

    assign data_mem_req_o = data_req_i;
    assign data_mem_addr_o = data_addr_i;
    assign data_mem_byte_en_o = data_byte_en_i;
    assign data_mem_wr_o = data_wr_i;
    assign data_mem_wr_data_o = data_wr_data_i;

    assign data_mem_rd_data_o = data_mem_rd_data;
endmodule
