module counter(input clk,rst,load,up_down,input[3:0]data,output reg [3:0]count); 	
 	always@(posedge clk)
	  begin
  	     if(rst)	
   		count <=4'd0;
	     else if(count == 4'd10)
	     	count <=4'd0;
       	     else if(load)
	        count <= data;
   	     else if(up_down)
	        count <= count + 1'b1;
	     else 
	        count <= count - 1'b1; 	     
      	   end
endmodule   	   
