
module CALC_Full #(parameter ADDRESS_WIDTH = 4) (
input wire                      CLK,RST,
input wire                      W_inc,
input wire  [ADDRESS_WIDTH:0]   Wq2_Rptr,
output wire [ADDRESS_WIDTH-1:0] W_addr,
output reg  [ADDRESS_WIDTH:0]   W_ptr,
output reg 		        FULL
);

reg  [ADDRESS_WIDTH:0] Binary_W_ptr;
wire [ADDRESS_WIDTH:0] Gray_W_ptr,Binary_W_ptr_n;
wire                   FULL_flag;

always @(posedge CLK or negedge RST)
begin 
if(!RST)
  begin
     FULL<='b0;
     W_ptr<='b0;
     Binary_W_ptr<='b0;
  end
 else
   begin
     FULL<=FULL_flag;
     W_ptr<=Gray_W_ptr;
     Binary_W_ptr<=Binary_W_ptr_n;
   end
 end

assign FULL_flag = ((Gray_W_ptr[ADDRESS_WIDTH-1] != Wq2_Rptr[ADDRESS_WIDTH-1]) &&
                   (Gray_W_ptr[ADDRESS_WIDTH-2] != Wq2_Rptr[ADDRESS_WIDTH-2]) &&
                  ( Gray_W_ptr[ADDRESS_WIDTH-3:0] == Wq2_Rptr[ADDRESS_WIDTH-3:0] ));

assign W_addr = Binary_W_ptr[ADDRESS_WIDTH-1:0];
assign Binary_W_ptr_n = Binary_W_ptr + (W_inc & !FULL);
assign Gray_W_ptr = (Binary_W_ptr_n >> 1)^Binary_W_ptr_n;


endmodule 