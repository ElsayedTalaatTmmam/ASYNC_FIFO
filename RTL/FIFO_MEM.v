
module FIFO_MEM #(parameter DATA_WIDTH = 8,
                  parameter ADDRESS_WIDTH = 4)(

input wire                     CLK,RST,
input wire [DATA_WIDTH-1:0]    Wr_DATA,
input wire                     W_INC,FULL,EMPTY,
input wire [ADDRESS_WIDTH-1:0] Wr_addr,Rd_addr,

output wire [DATA_WIDTH-1:0]    Rd_DATA
);
     parameter MEM_DEPTH = 16 ;
     integer  i;

reg [DATA_WIDTH-1:0] RAM [0:MEM_DEPTH-1];

always @ (posedge CLK or negedge RST)
  begin
      if (!RST)
	begin
           for (i=0; i<MEM_DEPTH; i=i+1)
              begin
                  RAM[i] <= 'b0;
	      end 
	end
      else if (!FULL && W_INC)
	begin
 		RAM[Wr_addr] <= Wr_DATA;
	end
  end

assign   Rd_DATA = RAM[Rd_addr];
/*
always @ (*)
begin
if (!EMPTY)
	begin
          Rd_DATA = RAM[Rd_addr];
	end
      else
        begin
          Rd_DATA = Rd_DATA;
	end
  end
*/
endmodule 