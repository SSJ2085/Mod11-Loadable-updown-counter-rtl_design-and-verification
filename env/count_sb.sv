class count_sb;
  
  event DONE;	
 
   count_trans rm_data; 
   count_trans sb_data;
   count_trans cov_data;
   
   static int ref_data_count, rdm_data_count , data_verified ;

   mailbox #(count_trans) ref2sb;
   mailbox #(count_trans) rdm2sb;

   covergroup counter_coverage;
	resetn : coverpoint cov_data.resetn;
	Load : coverpoint cov_data.load; 
	up_down : coverpoint cov_data.up_down;
	IN : coverpoint cov_data.data_in { bins data_in = {[0:10]};}
	OUT : coverpoint cov_data.count { bins count = {[0:10]};}
	ldxdin : cross Load,IN;
	moxldxxin: cross up_down,Load,IN;
   endgroup   

   function new (mailbox #(count_trans) ref2sb, 
                 mailbox #(count_trans) rdm2sb);
	this.ref2sb = ref2sb;
	this.rdm2sb = rdm2sb;
	counter_coverage = new();
   endfunction     
   virtual task start();
        fork
         forever
            begin

               ref2sb.get(rm_data);
               ref_data_count++;
               rdm2sb.get(sb_data);
               rdm_data_count++;
               check(sb_data);
            end
      join_none
   endtask: start

  virtual task check(count_trans rdata); 
   begin 
      if (rm_data.count == rdata.count) 
         $display("Count Matches");
      else
         $display("count does not match");
   end 
   cov_data = rm_data;
   counter_coverage.sample();

   data_verified++; 
   if(data_verified >=no_of_transactions+2) 
      begin 
         ->DONE; 
      end
   endtask

   virtual function report();
 	$display("***********************Scoreboard Report************************");
 	$display("data generated = %d",rm_data);
        $display("data varified = %d",data_verified);
	$display("****************************************************************");
   endfunction
endclass   




	
