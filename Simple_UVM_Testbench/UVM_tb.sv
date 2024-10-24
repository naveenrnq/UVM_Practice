// Producer Consumer example that uses TLM FIFO to communicate
//

 'include "uvm_macros.svh"

 // Top module test
 
 module test;
   import uvm_pkg::*;
   // Class Producer
   class producer extends uvm_component;
	   uvm_blocking_put_port #(int) put_port; // blocking put port with parameterized type integer
	   					  // Which means the producer
						  // will be communicating on
						  // the spot with some
						  // integer transactions

	   function new(string name, uvm_component p=null); // constructer to create the object of put_port
		   super.new(name,p);
                   put_port = new("put_port", this); // object of put_port by giving a name here
		   				     // "this" is the parent of
						     // the port 
           endfunction

	   task run_phase(uvm_phase phase); // Defines the run phase
		   int randval;

		   for(int i=0; i<10; i++) begin
			   randval = $random % 100; // will generate 10 random values in between 0 to 100
			   #10;  		    // After every number provide a delay
			   'uvm_info("producer", $sformatf("sending %4d", randval), UVM_MEDIUM)
			   put_port.put(randval);   // put randval to put_port
		   end
	   endtask
    endclass : producer

    // Class Consumer
    class consumer extends uvm_component;

	    uvm_blocking_get_port #(int) get_port; // consumer will be trying to pull the transaction
	    					   // through this port

	    function new(string name, uvm_component p = null);
		    super.new(name,p);
		    get_port = new("get_port", this);
	    endfunction


