class count_wr_mon;
   
   virtual count_if.WR_MON wr_mon_if;
   
   count_trans data2rm;
   count_trans wr_data;
   mailbox #(count_trans)mon2rm;

   function new(virtual count_if.WR_MON wr_mon_if,mailbox #(count_trans)mon2rm);
	begin
	   this.wr_mon_if = wr_mon_if;
           this.mon2rm = mon2rm; 
           this.wr_data = new;
        end
   endfunction

   virtual task monitor();
	begin
	   @(wr_mon_if.wr_cb);
	   begin
		wr_data.up_down = wr_mon_if.wr_cb.up_down;
                wr_data.load = wr_mon_if.wr_cb.load;
		wr_data.data_in  = wr_mon_if.wr_cb.din;
		wr_data.display("From Write Monitor");
	   end
	end
   endtask


   virtual task start();
       fork
	  forever
    	     begin
  		monitor();
		data2rm = new wr_data;
		mon2rm.put(data2rm);
	     end
       join_none
   endtask

endclass
