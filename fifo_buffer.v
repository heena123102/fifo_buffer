module fifo_buffer(clk,rst,rd_en,wr_en,din,dout,full,empty);
input clk,rst,rd_en,wr_en;
input [7:0]din;
output reg [7:0]dout;
//output full,empty;
output reg full =0;
output reg empty =0;
reg [7:0]mem[0:31];
reg [4:0]rd_ptr,wr_ptr;
always @(posedge clk or posedge rst)
begin
if (rst)
	begin
	wr_ptr=0;
	rd_ptr=0;
	end
else 
begin
if (rd_en==1 && wr_en==0 && (wr_ptr-rd_ptr == 31))
begin
 full =1;
 empty=0;
end
else if (rd_en==0 && wr_en==1 && (wr_ptr-rd_ptr==0) )
begin
 empty =0;
full =1;
end
//always @(posedge clk)
//begin
if (rd_en==1 && empty==0)
	begin
	dout = mem[rd_ptr];
//$display dout 
	rd_ptr = rd_ptr +1;
	//rd_ptr;
	end
else if (wr_en==1 && full ==0)
	begin
	mem[wr_ptr] = din;
	wr_ptr = wr_ptr +1;
	//wr_ptr;
	end
end
end
endmodule
/*
//test bench
module chk_mem;
reg clk,rst,rd_en,wr_en;
 reg [7:0]din;
wire  [7:0]dout;
//reg rd_ptr,wr_ptr;
 wire full,empty;
 fifo_buffer8_32 D1(clk,rst,rd_en,wr_en,din,dout,full,empty);
initial begin
	 #5 clk=0; rst=1; wr_en=0; rd_en=0; din=0; full=0; empty =0; dout = 0;
	 #5 clk=1; rst=0; wr_en=1; rd_en=0;
	 #330 wr_en=0; rd_en=1;
	 #660 wr_en=1; rd_en=1;
	 #1000 wr_en=0; rd_en=0;
	 end 
	 always #5 clk=~clk;
	 always #10 dout=$random;

endmodule */