
`timescale  1 ns / 1 ps

module file_reading
	(
	        input              clk, 
	        input              reset,     
		      output wire [19:0] img_write_addr,
	        output   [7:0]  img_write_data,
	        output         img_wr_enb,
	        output reg         hsync,
	        output reg         vsync,
	        output reg         start
	);

	parameter [19:0] K_IMG_INPUT = 76800;
	parameter [9:0]  K_H_SYNC    = 320;
 	parameter [9:0]  K_V_SYNC    = 240; 

	reg [19:0] inimg_addr;

	reg        first_flag;
	reg        wr_enb;
	reg [19:0] wr_addr;
	
	
	reg [19:0] inimg_addr_samp;
	reg        wr_enb_samp;

	integer    hsync_cnt;
	integer    vsync_cnt;

  integer    file_in;
  reg        read_line;
	reg [7:0]  img_write_data_samp;

	
  assign img_write_data = img_write_data_samp;
  assign img_wr_enb = wr_enb;
  assign img_write_addr   = wr_addr;

	initial 
	begin
 	      file_in  <=  $fopen("Databa23_320x240.hex","r");
  end
		

	always@ (posedge clk)
	begin
		if (!reset) 
		begin
			hsync_cnt       <=  'd0;
			vsync_cnt       <=  'd0;
			hsync           <= 1'b0;
			vsync           <= 1'b0;
			wr_addr         <=  'b0;
			wr_enb_samp     <= 1'b0;
			inimg_addr_samp <=  'b0;
		end
		else 
		begin
			hsync           <= 1'b0;
			vsync           <= 1'b0;
			inimg_addr_samp <= inimg_addr;
			wr_addr         <= inimg_addr_samp;
		       
			if (wr_enb == 1'b1) 
			begin
				if (hsync_cnt < K_H_SYNC-1) 
				begin 
				   hsync_cnt <= hsync_cnt + 1;
			  end
				else 
				begin
			     hsync_cnt <= 'd0;
				   hsync     <= 1'b1;
				   if (vsync_cnt < K_V_SYNC-1) 
				   begin
					   vsync_cnt <= vsync_cnt + 1;
				   end
				   else 
				   begin
				      vsync     <= 1'b1;
				      vsync_cnt <= 'd0;
			     end
			 end
		 end

	 end
	end

	always@ (posedge clk)
	begin
		
	    if (!reset) 
	    begin
			wr_enb         <= 1'b0;
			start          <= 1'b0;
			inimg_addr     <= 'b0;
			first_flag     <= 1'b0;
			read_line      <= 1'b0; 
			img_write_data_samp <= 'b0;
		  end
		  else 
		  begin
      read_line <= $fscanf(file_in,"%h\n", img_write_data_samp);
			if (!$feof(file_in)) 
			begin 
			      wr_enb           <= 1'b1;
			      first_flag       <= 1'b1;
			      if ((inimg_addr <= K_IMG_INPUT+1)) 
			      begin
				       inimg_addr <= inimg_addr + 1'b1;
			      end

		   end
		   else
		   begin
			       start           <= 1'b1;
			       wr_enb          <= 1'b0;
       end    
		end
	end
	
	
	
	 
endmodule


