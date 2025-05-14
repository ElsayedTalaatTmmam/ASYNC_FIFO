
`timescale 1ns/1ps

module ASYNC_FIFO_TB ;

parameter CLK_PERIOD_W = 10 ;
parameter CLK_PERIOD_R = 25 ;
parameter ADDRESS_WIDTH = 4 ;
parameter BUS_WIDTH = 8 ;



reg  [BUS_WIDTH-1:0] WR_DATA_TB;
reg                  W_CLK_TB,R_CLK_TB,RST_TB;
reg                  W_INC_TB,R_INC_TB;
wire                 FULL_TB;
wire                 EMPTY_TB;
wire [BUS_WIDTH-1:0] RD_DATA_TB;

always #(CLK_PERIOD_W/2) W_CLK_TB = ~W_CLK_TB ;
always #(CLK_PERIOD_R/2) R_CLK_TB = ~R_CLK_TB ;

ASYNC_FIFO #(.ADDRESS_WIDTH(ADDRESS_WIDTH),.DATA_WIDTH(BUS_WIDTH)) DUT (

.W_CLK(W_CLK_TB),
.RST(RST_TB),
.R_CLK(R_CLK_TB),
.Wr_DATA(WR_DATA_TB),
.Rd_data(RD_DATA_TB),
.EMPTY(EMPTY_TB),
.FULL(FULL_TB),
.W_INC(W_INC_TB),
.R_INC(R_INC_TB)
);


initial
 begin
 initialize() ;
 // Reset
 reset() ; 

#(5*CLK_PERIOD_W)
#(CLK_PERIOD_W/2)

//WRITE_DATA ('hAF,1);
WRITE_DATA ('hAF,1);
WRITE_DATA ('h47,1);
WRITE_DATA ('h1F,1);
WRITE_DATA ('h04,1);
WRITE_DATA ('hFF,1);
WRITE_DATA ('h16,1);
WRITE_DATA ('h14,1);
WRITE_DATA ('h98,1);
WRITE_DATA ('h23,1);
WRITE_DATA ('hF0,1);

#(6*CLK_PERIOD_W)
WRITE_DATA ('hAF,1);
WRITE_DATA ('h47,1);
WRITE_DATA ('h1F,1);
WRITE_DATA ('h04,1);
WRITE_DATA ('hFF,1);
WRITE_DATA ('h16,1);
WRITE_DATA ('h14,1);
WRITE_DATA ('h98,1);
WRITE_DATA ('h23,1);
WRITE_DATA ('hF0,1);
WRITE_DATA ('hAF,1);
#(5*CLK_PERIOD_W)
WRITE_DATA ('h47,1);
WRITE_DATA ('h1F,1);
WRITE_DATA ('h04,1);
WRITE_DATA ('hFF,1);
WRITE_DATA ('h16,1);
WRITE_DATA ('h14,1);
WRITE_DATA ('h98,1);
WRITE_DATA ('h23,1);
WRITE_DATA ('hF0,1);

#1000
$stop ; 
end

initial
 begin
 initialize() ;
 // Reset
 reset() ; 
R_INC_TB = 'b0;
#300;

READ_DATA ('hAF,0,1);
READ_DATA ('h47,1,1);
READ_DATA ('h1F,2,1);
READ_DATA ('h04,3,1);
READ_DATA ('hFF,4,1);
READ_DATA ('h16,5,1);
READ_DATA ('h14,6,1);
READ_DATA ('h98,7,1);
READ_DATA ('h23,8,1);
READ_DATA ('hF0,9,1);
READ_DATA ('hAF,10,1);
READ_DATA ('h47,11,1);
READ_DATA ('h1F,12,1);
READ_DATA ('h04,13,1);
READ_DATA ('hFF,14,1);
READ_DATA ('h16,15,1);
READ_DATA ('h14,16,1);
READ_DATA ('h98,17,1);
READ_DATA ('h23,18,1);
READ_DATA ('hF0,19,1);
READ_DATA ('hAF,20,1);
READ_DATA ('h47,21,1);
READ_DATA ('h1F,22,1);
READ_DATA ('h04,23,1);
READ_DATA ('hFF,24,1);
READ_DATA ('h16,25,1);
READ_DATA ('h14,26,1);
READ_DATA ('h98,27,1);
READ_DATA ('h23,28,1);
READ_DATA ('hF0,29,1);
#500 

R_INC_TB = 'b0;
#1000
$stop ; 
end


/////////////// Signals Initialization //////////////////

task initialize ;
  begin
	R_CLK_TB     = 1'b0 ;
	RST_TB       = 1'b1 ;   
	W_CLK_TB     = 1'b0 ;
        W_INC_TB     = 1'b0 ;
	R_INC_TB     = 1'b0 ;
	WR_DATA_TB   =  'b0 ;

  end
endtask

///////////////////////// RESET /////////////////////////

task reset ;
  begin
	#(CLK_PERIOD_W) ;
	RST_TB  = 'b0 ;          
	#(CLK_PERIOD_W) ;
	RST_TB  = 'b1 ;
	#(CLK_PERIOD_W) ;
  end
endtask

task WRITE_DATA;
  input [BUS_WIDTH-1:0] data;
  input                 W_Enable;
   begin 
      WR_DATA_TB = data;
      W_INC_TB = W_Enable;
# (2*CLK_PERIOD_W);
      W_INC_TB = 'b0;
# (5*CLK_PERIOD_W);
   end
endtask

task READ_DATA;
  input [BUS_WIDTH-1:0] data;
  input [4:0]           test_case;
  input                 R_Enable;

  reg [BUS_WIDTH-1:0] gener_out ,expec_out;
   begin 
      gener_out = data;
      R_INC_TB = R_Enable;

# (3*CLK_PERIOD_R);
      expec_out = RD_DATA_TB;

if(gener_out == expec_out) 
		begin
			$display("Test Case %d is succeeded",test_case);
			$display(" /////////////////////////// ");
		end
	else
		begin
			$display("Test Case %d is failed", test_case);
			$display(" /////////////////////////// ");
		end

   end
endtask

endmodule 

