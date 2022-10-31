module avg_black_pixel_density( 
								input	clk,
								input reset,	
								input data_valid,		
								input [19:0]read_addr,
         							input [7:0]filtered_data,
         							output data_valid_out,							
								output[9:0]oXcoord,oYcoord
											);
reg [29:0] sumX_r, sumY_r;
reg [18:0] cntr_r;
reg [29:0] avgX, avgY,avgX_r, avgY_r;
reg [18:0] density_p;

reg [9:0] Coord_X =0,Coord_Y=0;

reg [29:0] sumX, sumY;
reg [18:0] cntr;

assign oXcoord = avgX[9:0];
assign oYcoord = avgY[9:0];

always@(read_addr)
begin
  if(Coord_X < 319)
    Coord_X <= Coord_X + 1;
  else 
    begin
    Coord_X <= 0;
    Coord_Y <= Coord_Y + 1;
    end
end

assign data_valid_out = data_valid;


always @(posedge clk)
 begin
	if (!reset)
	begin	
		sumX <= 30'b0;
		sumY <= 30'b0;
		cntr <= 19'b0;	
		density_p <= 19'd0;
	end
	
	else if(data_valid)
     begin 
   // ********** Computing centroid for all detected pixels ********************************************** //
		if ((Coord_X > 10'd10) && (Coord_X < 10'd319) && (Coord_Y > 10'd0) && (Coord_Y < 10'd239))
	 	 begin
					$display("Coord_X = %d ,Coord_Y = %d, read_addr = %d",Coord_X,Coord_Y,read_addr);
			if (filtered_data == 8'h0)
			begin
				sumX <= sumX + Coord_X;
				sumY <= sumY + Coord_Y;
				cntr <= cntr + 19'b1;
		
			end
		 end		
		else if((Coord_Y == 10'd319) && (Coord_X == 10'd239) ) 
		 begin
			avgX <= sumX / cntr;
			avgY <= sumY / cntr;
			
			avgX_r <= avgX;
			avgY_r <= avgY;
			sumX_r <= sumX;
			sumY_r <= sumY;
			cntr_r <= cntr; 
			

		end
		else if (Coord_Y == 10'd0) 
		begin
			sumX <= 30'b0;
			sumY <= 30'b0;
			cntr <= 19'b0; 
		end
  end 		
 end 
 

endmodule 
