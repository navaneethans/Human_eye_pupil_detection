module double_threshold#(
	parameter data_width = 8,
	parameter line_width = 637
	)
	(
	input clock,
	input rst_n,
	input data_valid,
	input [data_width-1:0] data_in,
	output data_out_valid,
	output [data_width-1:0] data_out 
	);
	
	
	reg [data_width-1:0] result ;
	reg	  valid ;			
	reg [7:0] T_in ;
	reg [7:0] H_T ;
	reg [7:0] L_T ; 	
	
	reg [data_width-1:0] dly_data ;
	reg 	  dly0 ;
	reg 	  dly1 ;
 	wire 	 ex_valid ;
	
	wire  window_valid;

	wire [data_width-1:0] P1;
	wire [data_width-1:0] P2;
	wire [data_width-1:0] P3;
	wire [data_width-1:0] P4;
	wire [data_width-1:0] P5;
	wire [data_width-1:0] P6;
	wire [data_width-1:0] P7;
	wire [data_width-1:0] P8;
	wire [data_width-1:0] P9;
	
	assign data_out = result;
	assign data_out_valid = window_valid;
	
	always @(posedge clock)
		if(!rst_n) begin 
			dly0 <= 0 ;
			dly1 <= 0 ;
			dly_data <= 0 ;
		end 
		else begin 
			dly0 <= data_valid ;
			dly1 <= dly0 ;
			dly_data <= data_in ;
		end 

	assign ex_valid = (data_valid) ? data_valid : dly1 ;
	
	sliding_window #(
		.data_width(data_width),
		.clock_cycle(637)
	) 
	image_window_nms (
		.clk(clock),
		.rst_n(rst_n),
		.data_in_valid(ex_valid),
		.data_in(dly_data),
		.data_out_valid(window_valid),
		.P1(P1),
		.P2(P2),
		.P3(P3),
		.P4(P4),
		.P5(P5),
		.P6(P6),
		.P7(P7),
		.P8(P8),
		.P9(P9)
	);


	
	always@(posedge clock) 
		if(!rst_n) begin 
			H_T    <= 8'hFF; // set value to clear warning
			L_T    <= 8'hFF; // set value to clear warning
			T_in   <= 0;
		end 
		else if(data_valid) begin	
			T_in <= (data_in[7:0] > T_in ) ? data_in[7:0] : T_in ;
			H_T  <= T_in/10;
			L_T  <= {1'b0,H_T[7:1]};
		end 


	always@(posedge clock)
	begin
		if(!rst_n) 
		begin
			result <= P9[7:0] | P8[7:0] | P7[7:0] | P4[7:0] ; // its unconnected node used for clear warninng to connecting
		end 
		else if(window_valid)  
		begin 
			valid <= window_valid ;
			if(P5<L_T) 
			begin
				result <=8'h00;
			end
			else if (P5[7:0]>H_T) 
			begin
				result <=8'hFF;
			end
//			else 
//			begin 
//				if( (P2 !=0)||(P8 !=0)||(P3 !=0)||(P7!=0)||(P1 !=0)||(P9 !=0)|| (P4 !=0)||(P6 !=0)) 
//				begin
//					result <= 8'hFF;
//				end
				else 
				begin
					result <= 8'h00;
				end
			//end		
		end 
		else 
			valid <= window_valid ;
  end

endmodule
	

