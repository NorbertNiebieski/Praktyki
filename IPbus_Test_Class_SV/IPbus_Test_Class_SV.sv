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
