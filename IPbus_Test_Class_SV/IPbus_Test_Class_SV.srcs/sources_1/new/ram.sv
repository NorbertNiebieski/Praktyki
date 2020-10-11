`timescale 1ns / 1ps

module ipbus_ram                            
(                                           
  input [31:0] ipb_wdata,                   
  input [31:0] ipb_addr,                    
  input ipb_write, ipb_strobe, ipb_clk,     
  output ipb_ack, ipb_err,                  
  output reg [31:0] ipb_rdata               
);                                          
                                            
  // RAM variable                           
  reg [31:0] ram[7:0];              
                                            
  always @ (posedge ipb_clk)             
  begin                                     
  // Strobe                                 
    if (ipb_strobe)                         
    // Write                                
      if (ipb_write)                        
        ram[ipb_addr] <= ipb_wdata;         
    // Read                                 
      else                                  
        ipb_rdata <= ram[ipb_addr];         
      end                                   
                                            
  // Random functions for ACK and ERR       
  assign ipb_ack = |ipb_addr;               
  assign ipb_err = ^ipb_wdata;              
                                            
endmodule                                   
                                            
