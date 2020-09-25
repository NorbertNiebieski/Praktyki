module ipb_intf(
  
  virtual IPb_intf intf_in_module; 
  virtual IPb_intf intf_out_module;
  
endmodule


 task ipb_writing();    
     
            $display("%0d", ipb_addr );
            
            intf.intf_out_module.ipb_wdata = ipb_addr;
            
    endtask: ipb_writing
    
///////////////////////////////////////    
    
    task ipb_read();
              
            $display ("%0d ", ipb_rdata); 
            
            intf.intf_in_module.ipb_rdata = ipb_addr;            
 
    endtask: ipb_read