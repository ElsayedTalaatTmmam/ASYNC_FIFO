
module READ_PTR #(parameter ADDRESS_WIDTH = 4)(
input wire                    CLK,RST,
input wire  [ADDRESS_WIDTH:0] R_ptr,
output reg  [ADDRESS_WIDTH:0] Wq2_Rptr
);

reg  [ADDRESS_WIDTH:0] Wq1_Rptr;

always @ (posedge CLK or negedge RST)
begin
     if(!RST)
	begin
            Wq2_Rptr <=0;
            Wq1_Rptr <=0;
	end

     else
	begin
            Wq2_Rptr <= Wq1_Rptr;
            Wq1_Rptr <= R_ptr;
	end
end
endmodule 