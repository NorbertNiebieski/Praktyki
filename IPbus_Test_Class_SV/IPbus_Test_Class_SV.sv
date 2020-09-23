interface IPbusInterface( 	input  ipb_in,
				output  ipb_out);
	
	initial                            
	begin

		ipb_out.ipb_wdata = 0'b1;
		ipb_out.ipb_addr = 0'b1;
		ipb_out.ipb_write = 0'b1;
		ipb_out.ipb_strobe = 0'b1;
		ipb_in.data = 0'b1;
		ipb_in.ipb_rdata = 0'b1;
		ipb_in.ipb_ack = 0'b1;
		ipb_in.ipb_err = 0'b1;

	end
                           
endinterface: IPbusInterface


class IPbusTestClass;

	local virtual IPbusInterface  IPbusInterface1;
 
	task assignInterface( virtual IPbusInterface  IPbusInterface1);
        
		this.IPbusInterface1 = IPbusInterface1;    
    
	endtask: assignInterface
	
	function void write (string filepath, string text)
		
		int fileDescriptor;
		
		fileDescriptor = $fopen(filepath, "w");
		if (fd)  $display("File was opened successfully : %0d", fileDescriptor);
		else     $display("File was NOT opened successfully : %0d", ffileDescriptor);
		
		$fdisplay (fileDescriptor, text);
		
		$fclose(fileDescriptor);
		
	endfunction
	
		function string read(string filepath)
		
		int fileDescriptor;
		string line, text;
		
		fileDescriptor = $fopen(filepath, "r");
		if (fd)  $display("File was opened successfully : %0d", fileDescriptor);
		else     $display("File was NOT opened successfully : %0d", ffileDescriptor);
		
		while (!$feof(fd)) begin
		$fgets(line, fd);
		text = {text, line};
		$display ("Line: %s", line);
		end
		
		$fclose(fileDescriptor);
		
		return text
			
	endfunction
  
endclass: IPbusTestClass
