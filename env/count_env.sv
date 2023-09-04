class count_env; 
     virtual count_if.WR_DRV wr_drv_if; 
     virtual count_if.WR_MON wr_mon_if; 
     virtual count_if.RD_MON rd_mon_if;
 
     mailbox #(count_trans) gen2dr=new(); 
     mailbox #(count_trans) rm2sb=new();
     mailbox #(count_trans) mon2sb = new(); 
     mailbox#(count_trans) mon2rm = new(); 

    count_gen gen_h; 
    count_wr_mon wrmon_h; 
    count_drv drv_h; 
    count_rd_mon rdm_h; 
    count_sb sb_h; 
    count_ref_mod ref_mod_h; 

    function new (virtual count_if.WR_DRV wr_drv_if, 
		  virtual count_if.WR_MON wr_mon_if, 
   	          virtual count_if.RD_MON rd_mon_if); 
	this.wr_drv_if = wr_drv_if; 
	this.wr_mon_if = wr_mon_if; 
	this.rd_mon_if = rd_mon_if; 
    endfunction : new

    virtual task build();
	gen_h = new(gen2dr);
	drv_h = new(wr_drv_if,gen2dr);
        wrmon_h = new(wr_mon_if,mon2rm);
        rdm_h = new(rd_mon_if,mon2sb);
        sb_h = new(rm2sb,mon2sb);
        ref_mod_h = new(mon2rm,rm2sb); 
    endtask
 
    virtual task start();
	 gen_h.start();
        drv_h.start();
        wrmon_h.start();
        rdm_h.start();
        sb_h.start();
        ref_mod_h.start();

    endtask: start

    virtual task stop();
    	wait(sb_h.DONE.triggered);
    endtask: stop

    virtual task run();
        start();
        stop();
        sb_h.report();
    endtask

endclass: count_env


