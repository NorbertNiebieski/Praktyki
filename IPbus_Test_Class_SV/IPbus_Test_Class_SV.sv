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
	
	function void write (string filepath, string text); 
		
		int fileDescriptor;
		
		fileDescriptor = $fopen(filepath, "w");
		if (fileDescriptor)  $display("File was opened successfully : %0d", fileDescriptor);
		else     $display("File was NOT opened successfully : %0d", fileDescriptor);
		

		$fdisplay (fileDescriptor, text);

		$fclose(fileDescriptor);
		
	endfunction
	
	function string read(string filepath);
		
		int fileDescriptor;
		string line, text;
		
		fileDescriptor = $fopen(filepath, "r");
		if (fileDescriptor)  $display("File was opened successfully : %0d", fileDescriptor);
		else     $display("File was NOT opened successfully : %0d", fileDescriptor);
		
		while (!$feof(fileDescriptor)) begin
		$fgets(line, fileDescriptor);
		text = {text, line};
		$display ("Line: %s", line);
		end
		
		$fclose(fileDescriptor);
		
		return text;
			
	endfunction

    
  
endclass: IPbusTestClass

module ipbus_ram
(
  input [31:0] ipb_wdata,
  input [31:0] ipb_addr,
  input ipb_write, ipb_strobe, ipb_clk,
  output ipb_ack, ipb_err,
  output reg [31:0] ipb_rdata
);

  // RAM variable
  reg [31:0] ram[(2**32)-1:0];

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

module IPbusInterface(
  
  virtual IPbusInterface intf_in_module; 
  virtual IPbusInterface intf_out_module;
  
endmodule


 task ipb_writing();    
     
            $display("%0d", ipb_addr );
            
            intf.intf_out_module.ipb_wdata = ipb_addr;
            
 endtask: ipb_writing
    

    
 task ipb_read();
              
            $display ("%0d ", ipb_rdata); 
            
            intf.intf_in_module.ipb_rdata = ipb_addr;            
 
 endtask: ipb_read





module TestingIPbusTestClassModule;
   
    reg [31:0] ipb_wdata;
	reg [31:0] ipb_addr;
	reg ipb_write, ipb_strobe, ipb_clk;
	wire ipb_ack, ipb_err;
	wire [31:0] ipb_rdata;
	ipbus_ram m1( ipb_wdata, ipb_addr, ipb_write, ipb_strobe, ipb_clk, ipb_ack, ipb_err, ipb_rdata);
	
	always begin
        #5 ipb_clk = 1;  
        #5 ipb_clk = 0;
    end
	
	
	
	initial begin
    

    
    IPbusTestClass o1; 
    
    string filepath, text;
    filepath = "C:\Users\Norbert\Vivado\project_7\project_7.srcs\sim_1\new\test.txt";
    text = "testowanie";
	
    o1.write(filepath,text);
    $display(o1.read(filepath));
	
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	ipb_writing();
    ipb_read();
    
    end
    
endmodule: TestingIPbusTestClassModule

