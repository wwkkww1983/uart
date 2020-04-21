module sfifo_test();

	reg clk;
	reg rst_n;
	reg [7:0] data_in;
	reg wr;
	reg rd;
	wire full;
	wire empty;
	wire [7:0] data_out;
	wire [3:0] sfifo_cnt;

	//----Code starts here: integrated by Robei-----
	initial begin
	  rst_n=1;
	  clk=0;
	  wr=0;
	  rd=0;
	  data_in=0;
	  #1 rst_n=0;
	  #5 rst_n=1;
	  #3 wr=1;
	  #5 rd=1;
	  #5 rd=0;
	  #5 wr=0;
	  #5 wr=1;
	  #10 rd=1;
	  #10 rd=0;
	  #14 $finish;
	end
	always begin
	  #5 clk=~clk;
	end
	always @(posedge clk or negedge rst_n) begin
	  if (~rst_n) begin
	    data_in<=0;
	    wr<=0;
	    rd<=0;
	  end
	  else begin
	    data_in<=$random;
	  end
	end
	
	
	
	initial begin
		$dumpfile ("F:/Robei/practice/prac_07_sfifo/sfifo_test.vcd");
		$dumpvars;
	end
	//---Module instantiation---
	sfifo sfifo1(
		.clk(clk),
		.rst_n(rst_n),
		.data_in(data_in),
		.wr(wr),
		.rd(rd),
		.full(full),
		.empty(empty),
		.data_out(data_out),
		.sfifo_cnt(sfifo_cnt));

endmodule    //sfifo_test

