interface IPbusInterface( 	input  ipb_in,
				output  ipb_out);
	
	initial                            
	begin

		ipb_out.ipb_wdata = 1'b1;
		ipb_out.ipb_addr = 1'b1;
		ipb_out.ipb_write = 1'b1;
		ipb_out.ipb_strobe = 1'b1;
		ipb_in.data = 1'b1;
		ipb_in.ipb_rdata = 1'b1;
		ipb_in.ipb_ack = 1'b1;
		ipb_in.ipb_err = 1'b1;

	end
                           
endinterface: IPbusInterface


class IPbusTestClass;

	local virtual IPbusInterface  IPbusInterface1;
 
	task assignInterface( virtual IPbusInterface  IPbusInterface1);
        
		this.IPbusInterface1 = IPbusInterface1;    
    
	endtask: assignInterface
  
endclass: IPbusTestClass
