`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:02:10 07/14/2021 
// Design Name: 
// Module Name:    logic_OR 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module logic_OR #(
	                 parameter data_width= 8,
	                 parameter clock_cycle = 317
	              )
	             
	            ( input clock, input rst_n, data_valid ,input [7:0] data_in, output [7:0] data_out, output data_out_valid ); 
  
  reg [7:0] Pixel_1, Pixel_2, Pixel_3, Pixel_4, Pixel_5, Pixel_6, Pixel_7, Pixel_8, Pixel_9; 
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
	
	//assign data_out = result;
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
		.clock_cycle(317)
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
 begin 
 if(!rst_n) 
 begin
 Pixel_1 <= 8'd1;
 Pixel_2 <= 8'd1;
 Pixel_3 <= 8'd1; 
 Pixel_4 <= 8'd1;
 Pixel_5 <= 8'd1;
 Pixel_6 <= 8'd1;
 Pixel_7 <= 8'd1; 
 Pixel_8 <= 8'd1;
 Pixel_9 <= 8'd1; 
 
 end 
 else if(window_valid)
 begin 
 Pixel_1 <=  P1; 
 Pixel_2 <= P2;
 Pixel_3 <= P3; 
 Pixel_4 <= P4; 
 Pixel_5 <=  P5;
 Pixel_6 <=  P6;
 Pixel_7 <=  P7; 
 Pixel_8 <=  P8; 
 Pixel_9 <=  P9; 

 end 
 end
 
  assign data_out = (Pixel_9 | Pixel_8 | Pixel_7 | Pixel_6 | Pixel_5 | Pixel_4 | Pixel_3 | Pixel_2 | Pixel_1); // dilation
  
 endmodule 

