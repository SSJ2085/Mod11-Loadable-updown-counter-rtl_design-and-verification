class test; 
    virtual count_if.WR_DRV dr_if; 
    virtual count_if.WR_MON wr_mon_if; 
    virtual count_if.RD_MON rd_mon_if;

    count_env env_h; 
    
    function new (virtual count_if.WR_DRV dr_if, 
		  virtual count_if.WR_MON wr_mon_if, 
		  virtual count_if.RD_MON rd_mon_if); 
	this.dr_if  = dr_if; 
        this.wr_mon_if = wr_mon_if; 
	this.rd_mon_if =rd_mon_if;
        env_h =  new(dr_if, wr_mon_if,rd_mon_if);  
     endfunction 

     virtual task build(); 
   	  env_h.build();
     endtask: build

     virtual task run();
	  env_h.run();
     endtask


endclass
