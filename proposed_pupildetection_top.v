`define DATA_WIDTH 8
module proposed_pupildetection_top(input clk, rst,
                  output [`DATA_WIDTH-1:0]image_data,
                  output [9:0]xcenter,ycenter
                  );

wire [`DATA_WIDTH-1:0]dout_read;
wire [19:0]data_addr;
wire dout_read_en;
wire wren;
wire [7:0]P1,P2,P3,P4,P5,P6,P7,P8,P9;

file_reading hex_read
	(
	        .clk(clk), 
	        .reset(rst),     
		      .img_write_addr(data_addr),
	        .img_write_data(dout_read),
	        .img_wr_enb(wren),
	        .hsync(),
	        .vsync(),
	        .start()
	);
	
//////////Hysteresis threshold///////////////	
wire [7:0]threshold_img;
wire th_valid;

double_threshold #(
                      	.data_width (8),
	                     .line_width (317)
                      )
	           double_thresh_dut
	(
	.clock(clk),
	.rst_n(rst),
	.data_valid(wren),
	.data_in(dout_read),
	.data_out_valid(th_valid),
	.data_out(threshold_img) 
	);
///////////////////////Morphology dilation ////////////////////////////////

wire [7:0] logical_or_out;
wire logical_or_out_valid;
logic_OR    #(
                  	.data_width (8),
	                 .clock_cycle(317)
             )
             OR_dut( .clock(clk),
                   .rst_n(rst), 
                   .data_valid(th_valid),
                   .data_in(threshold_img), 
                   .data_out(logical_or_out), 
                   .data_out_valid(logical_or_out_valid) 
                   
                   ); 

////////////////////////Morphology closing /////////////////////////////////////
wire [7:0]morp_out_data;
wire morp_out_valid;
morphology_operation 
#(
                  	.data_width (8),
	                 .clock_cycle(317)
             )   
             morp_closing( .clock(clk),
                   .rst_n(rst), 
                   .data_valid(logical_or_out_valid),
                   .data_in(logical_or_out), 
                   .data_out(morp_out_data), 
                   .data_out_valid(morp_out_valid) 
                   
                   ); 
  ///////////////////////////////////////////////////////
  
  avg_black_pixel_density cog_dut( 
								.clk(clk),
								.reset(rst),			
								.read_addr(data_addr),
								.data_valid(morp_out_valid),
         							.filtered_data(morp_out_data),	
         							.data_valid_out(),						
								.oXcoord(xcenter),
								.oYcoord(ycenter)
											);


///////////////////////////////////////////////////////////////////////
				  
//file_writing_doublethreshold dut7(.data_in(threshold_img),  
//				        .clk(clk),
//				        .rst(rst),
//				        .w_en(th_valid)
//				  );
//				  
//file_writing_dilation dut8(.data_in(dilated_data),  
//				        .clk(clk),
//				        .rst(rst),
//				        .w_en(dilate_valid)              
//				  );
//				  
//file_writing_closing dut9(.data_in(eroded_data),  
//				        .clk(clk),
//				        .rst(rst),
//				        .w_en(erode_valid)                            
//				  );

endmodule

	   
	 
	   

