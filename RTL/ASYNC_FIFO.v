
module ASYNC_FIFO #( parameter DATA_WIDTH = 8,
                     parameter ADDRESS_WIDTH = 4 )
(
input wire                    W_CLK,R_CLK,RST,
input wire                    W_INC,R_INC,
input wire [DATA_WIDTH-1:0]   Wr_DATA,
output wire [DATA_WIDTH-1:0]   Rd_data,
output wire                    FULL,
output wire                    EMPTY
);

wire [ADDRESS_WIDTH-1:0] Wr_addr,Rd_addr;
wire [ADDRESS_WIDTH:0] Wr_PTR,Rd_PTR;
wire [ADDRESS_WIDTH:0] wq2_rptr,rq2_wptr;

FIFO_MEM #(.DATA_WIDTH(DATA_WIDTH),.ADDRESS_WIDTH(ADDRESS_WIDTH)) MEM(
.CLK(W_CLK),
.RST(RST),
.Wr_DATA(Wr_DATA),
.Rd_DATA(Rd_data),
.W_INC(W_INC),
.FULL(FULL),
.EMPTY(EMPTY),
.Wr_addr(Wr_addr),
.Rd_addr(Rd_addr)
);

CALC_Full #(.ADDRESS_WIDTH(ADDRESS_WIDTH)) FULLU0(
.CLK(R_CLK),
.RST(RST),
.FULL(FULL),
.Wq2_Rptr(wq2_rptr),
.W_inc(W_INC),
.W_addr(Wr_addr),
.W_ptr(Wr_PTR)
);

CALC_EMPTY #(.ADDRESS_WIDTH(ADDRESS_WIDTH)) EMPTYU0(
.CLK(W_CLK),
.RST(RST),
.EMPTY(EMPTY),
.Rq2_Wptr(rq2_wptr),
.R_inc(R_INC),
.R_addr(Rd_addr),
.R_ptr(Rd_PTR)
);

READ_PTR #(.ADDRESS_WIDTH(ADDRESS_WIDTH)) read(
.CLK(W_CLK),
.RST(RST),
.R_ptr(Rd_PTR),
.Wq2_Rptr(wq2_rptr)
);

WRITE_PTR #(.ADDRESS_WIDTH(ADDRESS_WIDTH)) write(
.CLK(R_CLK),
.RST(RST),
.Rq2_Wptr(rq2_wptr),
.W_ptr(Wr_PTR)
);

endmodule 