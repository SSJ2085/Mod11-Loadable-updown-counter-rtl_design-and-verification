module top();

  import count_pkg::*;

  reg clock;

  count_if DUV_IF(clock);

  test t_h;
  
  counter DUV(.clk(clock),.rst(DUV_IF.resetn),.load(DUV_IF.load),
                    .up_down(DUV_IF.up_down),.data(DUV_IF.din),
			.count(DUV_IF.count));

  initial 
	begin
	   clock = 1'b0;
	   forever
	   #10 clock = ~clock;
        end

  initial
       begin
          if($test$plusargs("TEST1"))
		begin
		     t_h = new(DUV_IF,DUV_IF,DUV_IF);
		     no_of_transactions = 400;
		     t_h.build();
		     t_h.run();
		     $finish;
		end
	  
           if($test$plusargs("TEST2"))
		begin
 		     t_h=new(DUV_IF,DUV_IF,DUV_IF);
 		    no_of_transactions=2000;
 		    t_h.build();
 		    t_h.run();
 		    $finish;
		end
	end

endmodule

