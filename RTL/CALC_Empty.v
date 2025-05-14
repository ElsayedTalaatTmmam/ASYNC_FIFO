
module CALC_EMPTY #(parameter ADDRESS_WIDTH = 4) (

input wire                      CLK,RST,
input wire                      R_inc,
input wire  [ADDRESS_WIDTH:0]   Rq2_Wptr,
output wire [ADDRESS_WIDTH-1:0] R_addr,
output reg  [ADDRESS_WIDTH:0]   R_ptr,
output reg 		        EMPTY
);

reg  [ADDRESS_WIDTH:0] Binary_R_ptr;
wire [ADDRESS_WIDTH:0] Gray_R_ptr,Binary_R_ptr_n;
wire                   EMPTY_flag;

always @(posedge CLK or negedge RST)
begin 
if(!RST)
  begin
     EMPTY<='b0;
     R_ptr<='b0;
     Binary_R_ptr<='b0;
  end
 else
   begin
     EMPTY<=EMPTY_flag;
     R_ptr<=Gray_R_ptr;
     Binary_R_ptr<=Binary_R_ptr_n;
   end
 end

assign EMPTY_flag = (Gray_R_ptr == Rq2_Wptr);
assign R_addr = Binary_R_ptr[ADDRESS_WIDTH-1:0];
assign Binary_R_ptr_n = Binary_R_ptr + (R_inc & !EMPTY);
assign Gray_R_ptr = (Binary_R_ptr_n >> 1)^Binary_R_ptr_n;


endmodule 