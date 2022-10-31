
module file_writing(input [7:0]data_in, 
				  input clk,rst,w_en
				  );

parameter col = 640; 
parameter row = 480;	

integer f;
reg [18:0]i;

initial f = $fopen("Databa23_logical_and.hex");

always @(posedge clk) 
 begin 
    if(!rst)
	 begin
	  i <=0;  
	 end 
	else if(i<(row*col))
	 begin 
	  if(w_en)
	   begin
	    $fwrite(f,"%h\n",data_in);
		i <= i + 1;
	   end 	  
     end 
    else 
      $fclose(f);	
 end 
 
 endmodule