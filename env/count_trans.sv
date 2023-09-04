class count_trans; 
   
   rand logic [3:0]data_in;
   rand bit  load;
   rand bit up_down;
   rand bit resetn;
   logic [3:0]count;

   static int no_of_rst;
   static int no_of_load;
   static int no_of_upcount;
   static int no_of_downcount;

   
   constraint C1 {data_in inside{[0:10]};}
  // constraint C2 {count inside{[0:10]};}
   constraint C3 {load dist { 1 := 30, 0 :=70};}
   constraint C4 {up_down dist { 0 :=50 , 1:=50};}
   constraint C5 {resetn dist { 0 :=70 , 1:=30};}


   function void display(input string s);
	begin
	     $display("***********************%s******************",s);
 	     $display("data_in = %d",data_in);
	     $display("Up_down = %d",up_down);
             $display("load = %d",load);
	     $display("count = %d",count);
	     $display("resetn = %d",resetn);
	     $display("*******************************************");
        end
   endfunction

   function void post_randomize();
	if(this.resetn==1||this.resetn==0)
		 no_of_rst++;
	if(this.load==1 || this.load==0)
		 no_of_load++;
	if(this.up_down==1)
 		no_of_upcount++;
	if(this.up_down==0)
 		no_of_downcount++;
	this.display("randomized data");
   endfunction
endclass 
