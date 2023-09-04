class count_drv;
   // Instantiate virtual interface instance wr_drv_if of type ram_if with WR_DRV_MP modport
   virtual count_if.WR_DRV  wr_drv_if;

   // Declare a handle for ram_trans as 'data2duv'
   count_trans data2duv;

   // Declare a mailbox 'gen2wr' parameterized with ram_trans
   mailbox #(count_trans) gen2dr;
   function new(virtual count_if.WR_DRV wr_drv_if,
                mailbox #(count_trans)gen2dr);
      this.wr_drv_if = wr_drv_if;
      this.gen2dr    = gen2dr;
   endfunction: new

   virtual task drive();
      begin
         @(wr_drv_if.dr_cb);
   	      wr_drv_if.dr_cb.load<= data2duv.load;
   	      wr_drv_if.dr_cb.din <= data2duv.data_in;
              wr_drv_if.dr_cb.up_down <= data2duv.up_down;
      end
   endtask
  
   virtual task start();
      fork 
	forever
	    begin
        	gen2dr.get(data2duv);
		drive();
	    end
       join_none
    endtask
endclass
	      


