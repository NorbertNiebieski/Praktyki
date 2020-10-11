typedef struct packed{
        logic [31:0] ipb_addr;
        logic [31:0] ipb_wdata;
        logic ipb_strobe;
        logic ipb_write;
}ipb_wbus;


typedef struct packed{
        logic [31:0] ipb_rdata;
        logic ipb_ack;
        logic ipb_err;
}ipb_rbus;

interface IPbusInterface( input ipb_rbus ipb_in,
                    output ipb_wbus ipb_out,
					logic ipb_clk
					);                           
    initial
    begin
    ipb_in.ipb_rdata = 32'hffffffff;   
    ipb_in.ipb_ack = 1'b1;
    ipb_in.ipb_err = 1'b1; 
    
    ipb_out.ipb_wdata = 32'hffffffff;  
    ipb_out.ipb_addr = 32'hffffffff;   
    ipb_out.ipb_write = 1'b0;
    ipb_out.ipb_strobe = 1'b1;
    end     
                         
endinterface: IPbusInterface


class IPbusTestClass;
	
	virtual IPbusInterface IPbusInterface1;
 
    function assign_interface( virtual IPbusInterface IPbusInterface1);
        this.IPbusInterface1 = IPbusInterface1;       
    endfunction
 	
	task write_to_file(string filepath, int number_of_adress); 
		
		int fileDescriptor;
		
		@(posedge  IPbusInterface1.ipb_clk);
		IPbusInterface1.ipb_out.ipb_write = 0;
		IPbusInterface1.ipb_out.ipb_addr = 0;
		
		fileDescriptor = $fopen(filepath, "w");
		if (fileDescriptor)  $display("File was opened successfully : %0d", fileDescriptor);
		else     $display("File was NOT opened successfully : %0d", fileDescriptor);
		
		while ( IPbusInterface1.ipb_out.ipb_addr < number_of_adress )begin
		
		  @(posedge  IPbusInterface1.ipb_clk);
		  IPbusInterface1.ipb_out.ipb_write = 0;
          IPbusInterface1.ipb_out.ipb_strobe = 1;
          
          @(negedge IPbusInterface1.ipb_clk);
          
		  $fdisplay(fileDescriptor,"%h %h", IPbusInterface1.ipb_out.ipb_addr, IPbusInterface1.ipb_in.ipb_rdata);
		  $display("%h %h", IPbusInterface1.ipb_out.ipb_addr, IPbusInterface1.ipb_in.ipb_rdata);
		  IPbusInterface1.ipb_out.ipb_addr = IPbusInterface1.ipb_out.ipb_addr+1;
            
		end

		IPbusInterface1.ipb_out.ipb_addr = 0;

		$fclose(fileDescriptor);
		
	endtask
	
	task read_from_file(string filepath);
		
		int fileDescriptor;
		int addr;
		int value;

		
		@(posedge  IPbusInterface1.ipb_clk);
		fileDescriptor = $fopen(filepath, "r");
		if (fileDescriptor)  $display("File was opened successfully : %0d", fileDescriptor);
		else     $display("File was NOT opened successfully : %0d", fileDescriptor);
		
		while (!$feof(fileDescriptor)) begin
            
            @(posedge  IPbusInterface1.ipb_clk);
            $fscanf(fileDescriptor,"%h %h", addr, value);
            
            this.write(value, addr);
            
		end
		

		$fclose(fileDescriptor);
			
	endtask

    task read(input [31:0] addres);
        
        @(posedge  IPbusInterface1.ipb_clk);
          
        IPbusInterface1.ipb_out.ipb_write = 0;
        IPbusInterface1.ipb_out.ipb_strobe = 1;
        
        IPbusInterface1.ipb_out.ipb_addr = addres;
 
        @(negedge IPbusInterface1.ipb_clk);       

        $display("%0h", IPbusInterface1.ipb_in.ipb_rdata);
            
    endtask

    task write(input [31:0] word, input [31:0] addres); 
            
        @(posedge  IPbusInterface1.ipb_clk);
        
        IPbusInterface1.ipb_out.ipb_write = 1;
        IPbusInterface1.ipb_out.ipb_strobe = 1;
        
        IPbusInterface1.ipb_out.ipb_addr = addres;
        IPbusInterface1.ipb_out.ipb_wdata = word;
        
                               
    endtask    
    
endclass: IPbusTestClass

