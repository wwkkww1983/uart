module uart(
	clk,
	rst_n,
	rx,
	tx_en,
	data_send,
	tx_buf_full,
	rx_buf_full,
	tx,
	data_received);

	//---Ports declearation: generated by Robei---
	input clk;
	input rst_n;
	input rx;
	input tx_en;
	input [7:0] data_send;
	output tx_buf_full;
	output rx_buf_full;
	output tx;
	output [8:0] data_received;

	wire clk;
	wire rst_n;
	wire rx;
	wire tx_en;
	wire [7:0] data_send;
	reg tx_buf_full;
	reg rx_buf_full;
	reg tx;
	reg [8:0] data_received;

	//----Code starts here: integrated by Robei-----
	`define DEL 1
	
	//
	// This block is used to receive data
	//
	reg         rx_q;
	wire        rx_start;
	reg  [7:0]  rx_cnt;
	reg         rx_cnt_en;
	
	// 
	// Edge deteted
	//
	always @( posedge clk or negedge rst_n ) begin
	  if( ~rst_n ) begin
	    rx_q <= #`DEL 1'b0;
	  end
	  else begin
	    rx_q <= #`DEL rx;
	  end
	end      
	// Falling edge effective
	assign rx_start = ( rx_q && ~rx );
	
	//
	// Generate the count enable signal 
	//
	always @( posedge clk or negedge rst_n ) begin
	  if( ~rst_n ) begin
	    rx_cnt_en <= #`DEL 1'b0;
	  end
	  //
	  // Count enable
	  else if( rx_start ) begin
	    rx_cnt_en <= #`DEL 1'b1;
	  end
	  //
	  // Count disable
	  else if( rx_cnt == 8'd169 ) begin
	    rx_cnt_en <= #`DEL 1'b0;
	  end
	end     
	
	//
	// Frequence division
	//
	always @( posedge clk or negedge rst_n ) begin
	  if ( ~rst_n ) begin
	    rx_cnt <= #`DEL 8'd0;
	  end
	  else if ( rx_cnt_en ) begin
	    rx_cnt <= #`DEL rx_cnt + 8'b1;
	  end
	  else begin
	    rx_cnt <= #`DEL 8'b0;
	  end
	end
	
	reg [8:0] data_received_temp;
	//
	// FSM
	//
	always @( posedge clk or negedge rst_n ) begin
	  if( ~rst_n ) begin
	    data_received_temp <= #`DEL 9'b0;
	    rx_buf_full        <= #`DEL 1'b0;
	  end
	  else if( rx_cnt_en ) begin
	    case( rx_cnt ) 
	      8'd24: begin
	        data_received_temp[0] <= #`DEL rx;
	        rx_buf_full           <= #`DEL 1'b0;
	      end  // Least significant bit
	      8'd40: begin
	        data_received_temp[1] <= #`DEL rx;
	        rx_buf_full           <= #`DEL 1'b0;
	      end
	      8'd56: begin
	        data_received_temp[2] <= #`DEL rx;
	        rx_buf_full           <= #`DEL 1'b0;
	      end
	      8'd72: begin
	        data_received_temp[3] <= #`DEL rx;
	        rx_buf_full           <= #`DEL 1'b0;
	      end
	      8'd88: begin
	        data_received_temp[4] <= #`DEL rx;
	        rx_buf_full           <= #`DEL 1'b0;
	      end
	      8'd104: begin
	        data_received_temp[5] <= #`DEL rx;
	        rx_buf_full           <= #`DEL 1'b0;
	      end
	      8'd120: begin
	        data_received_temp[6] <= #`DEL rx;
	        rx_buf_full           <= #`DEL 1'b0;
	      end
	      8'd136: begin
	        data_received_temp[7] <= #`DEL rx;
	        rx_buf_full           <= #`DEL 1'b0;
	      end  // Most significant bit
	      8'd152: begin
	        data_received_temp[8] <= #`DEL rx;
	        rx_buf_full           <= #`DEL 1'b0;
	      end  // Parity check
	      8'd168: begin
	        rx_buf_full           <= #`DEL 1'b1;
	      end  // Stop bit
	      default:begin
	        rx_buf_full           <= #`DEL 1'b0;
	      end
	    endcase
	  end// Least significant bit
	end    
	
	always @( posedge clk or negedge rst_n ) begin
	  if( ~rst_n ) begin
	    data_received <= #`DEL 9'b0;
	  end
	  else if( rx_cnt == 8'd168 ) begin
	    data_received <= #`DEL data_received_temp;  // Ensure data can be collected
	  end
	end      
	
	//
	// This block is used to transmit data
	//
	reg         tx_en_q;
	wire        tx_start;
	reg  [7:0]  tx_cnt;
	reg         tx_cnt_en;
	reg  [8:0]  shift_reg;
	
	// 
	// Edge deteted
	//
	always @( posedge clk or negedge rst_n ) begin
	  if( ~rst_n ) begin
	    tx_en_q <= #`DEL 1'b0;
	  end
	  else begin
	    tx_en_q <= #`DEL tx_en;
	  end
	end      
	// Rising edge effective
	assign tx_start = ( ~tx_en_q && tx_en );
	
	//
	// Transmit data_send to shift_reg
	//
	always @( posedge tx_start or negedge rst_n ) begin
	  if( ~rst_n ) begin
	    shift_reg <= #`DEL 9'd0;
	  end
	  else begin
	    shift_reg[7:0] <= #`DEL data_send;
	    //
	    // Parity check bit, even parity
	    shift_reg[8]   <= #`DEL ( ^data_send ) ? 1 : 0;   
	  end
	end      
	
	//
	// Generate the count enable signal 
	// Generate the tx_buf_full signal which means shift_reg is not empty
	always @( posedge clk or negedge rst_n ) begin
	  if( ~rst_n ) begin
	    tx_cnt_en   <= #`DEL 1'b0;
	    tx_buf_full <= #`DEL 1'b0;
	  end
	  //
	  // Count enable
	  else if( tx_start ) begin
	    tx_cnt_en   <= #`DEL 1'b1;
	    tx_buf_full <= #`DEL 1'b1;
	  end
	  //
	  // Count disable
	  else if( tx_cnt == 8'd176 ) begin
	    tx_cnt_en   <= #`DEL 1'b0;
	    tx_buf_full <= #`DEL 1'b0;
	  end
	end     
	
	//
	// Frequence division
	//
	always @( posedge clk or negedge rst_n ) begin
	  if ( ~rst_n ) begin
	    tx_cnt <= #`DEL 8'd0;
	  end
	  else if ( tx_cnt_en ) begin
	    tx_cnt <= #`DEL tx_cnt + 8'b1;
	  end
	  else begin
	    tx_cnt <= #`DEL 8'b0;
	  end
	end
	
	//
	// FSM
	//
	always @( posedge clk or negedge rst_n ) begin
	  if( ~rst_n ) begin
	    tx <= #`DEL 1'b1;
	  end
	  else if( tx_cnt_en ) begin
	    case( tx_cnt ) 
	      8'd0: begin
	        tx <= #`DEL 1'b0;
	      end  // Start signal
	      8'd16: begin
	        tx <= #`DEL shift_reg[0];
	      end  // Least significant bit
	      8'd32: begin
	        tx <= #`DEL shift_reg[1];
	      end
	      8'd48: begin
	        tx <= #`DEL shift_reg[2];
	      end
	      8'd64: begin
	        tx <= #`DEL shift_reg[3];
	      end
	      8'd80: begin
	        tx <= #`DEL shift_reg[4];
	      end
	      8'd96: begin
	        tx <= #`DEL shift_reg[5];
	      end
	      8'd112: begin
	        tx <= #`DEL shift_reg[6];
	      end  
	      8'd128: begin
	        tx <= #`DEL shift_reg[7];
	      end  // Most significant bit
	      8'd144: begin
	        tx <= #`DEL shift_reg[8];
	      end  // Parity check      
	      8'd160: begin
	        tx <= #`DEL 1'b1;
	      end  // Stop bit
	    endcase
	  end
	end      
	
endmodule    //uart

