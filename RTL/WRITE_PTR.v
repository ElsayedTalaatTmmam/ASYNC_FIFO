module WRITE_PTR #(parameter ADDRESS_WIDTH = 4)(
input wire                    CLK,RST,
input wire  [ADDRESS_WIDTH:0] W_ptr,
output reg  [ADDRESS_WIDTH:0] Rq2_Wptr
);

reg  [ADDRESS_WIDTH:0] Rq1_Wptr;

always @ (posedge CLK or negedge RST)
begin
     if(!RST)
	begin
            Rq2_Wptr <=0;
            Rq1_Wptr <=0;
	end

     else
	begin
            Rq2_Wptr <= Rq1_Wptr;
            Rq1_Wptr <= W_ptr;
	end
end
endmodule 