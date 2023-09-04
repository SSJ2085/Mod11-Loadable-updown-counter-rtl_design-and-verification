interface count_if (input bit clock); 
   //Interface Signals 
   logic [3:0]din; 
   logic [3:0]count; 
   logic load; 
   logic up_down; 
   logic resetn;


   // Driver Clocking Block
   clocking dr_cb@(posedge clock);
   	default input #1 output #1;
   	output din;
   	output load;
   	output up_down;
        output resetn;
   endclocking

   clocking wr_cb@(posedge clock);
        default input #1 output #1;
        input din;
        input load;
        input up_down;
        input resetn;
   endclocking

   clocking rd_cb@(posedge clock); 
        default input # 1 output #1; 
        input count; 
   endclocking 


   modport WR_DRV (clocking dr_cb);
   modport WR_MON (clocking wr_cb); 
   modport RD_MON (clocking rd_cb); 

endinterface : count_if
