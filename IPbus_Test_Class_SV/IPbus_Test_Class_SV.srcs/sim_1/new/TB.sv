`include "IPbusTestClass.svh"
`timescale 1ns / 1ps



module TB();
    
    IPbusInterface IPbusInterface1_in_module(
                        .ipb_in(ipb_in),
                        .ipb_out(ipb_out),
                        .ipb_clk(ipb_clk)
                        );
                     
    ipbus_ram RAM ( IPbusInterface1_in_module.ipb_out.ipb_wdata, IPbusInterface1_in_module.ipb_out.ipb_addr, IPbusInterface1_in_module.ipb_out.ipb_write, IPbusInterface1_in_module.ipb_out.ipb_strobe, IPbusInterface1_in_module.ipb_clk, IPbusInterface1_in_module.ipb_in.ipb_ack, IPbusInterface1_in_module.ipb_in.ipb_err, IPbusInterface1_in_module.ipb_in.ipb_rdata);                    
	//ipbus_ram RAM( .RAMInitf (IPbusInterface1_in_module));
	IPbusTestClass tmp;
	
	initial begin
	   tmp = new();
	   tmp.assign_interface( IPbusInterface1_in_module );
	end
	
	// clk generator
	always begin
        IPbusInterface1_in_module.ipb_clk = 1; #5;  
        IPbusInterface1_in_module.ipb_clk = 0; #5; 
    end
    
	default clocking test @ (posedge IPbusInterface1_in_module.ipb_clk);
    endclocking
	
	task test_r();
	   
	   ##5 tmp.write( 32'h11111111, 0);
	   ##5 tmp.write( 32'h22222222, 1);
	   ##5 tmp.write( 32'h33333333, 2);
	   ##5 tmp.write( 32'h44444444, 3);
	   ##5 tmp.write( 32'h55555555, 4);
	   ##5 tmp.write( 32'h66666666, 5);
	   ##5 tmp.write( 32'haaaaaaaa, 6);
	   ##5 tmp.write( 32'hbbbbbbbb, 7);
	   
	   ##5;
	   
	   ##5 tmp.read(0);
	   ##5 tmp.read(1);
	   ##5 tmp.read(2);
	   ##5 tmp.read(3);
	   ##5 tmp.read(4);
	   ##5 tmp.read(5);
	   ##5 tmp.read(6);
	   ##5 tmp.read(7);
	   	   
	endtask;
		   							
	initial begin
    
    int number_of_adres=8;
    string readfilepath, writefilepath;
    readfilepath = "C:/Users/Norbert/Vivado/Praktyki/IPbus_Test_Class_SV/IPbus_Test_Class_SV.srcs/sim_1/new/read.txt";
    writefilepath = "C:/Users/Norbert/Vivado/Praktyki/IPbus_Test_Class_SV/IPbus_Test_Class_SV.srcs/sim_1/new/write.txt";
	
	$display("\n\n\n");
	
	##5
	$display("Testing RAM read and write");
	test_r();
	
	##5
	$display("Testing read from file");
    tmp.read_from_file(readfilepath);
    
    ##10
	$display("Testing write to file");
    tmp.write_to_file(writefilepath, number_of_adres);
    
    $display("\n\n\n");
    
    ##20 $finish ;  
   
    end
    
endmodule: TB
