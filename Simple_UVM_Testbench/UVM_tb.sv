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
		    get_port = new("get_port", this); // creating instance of this get_port
	    endfunction


	    task run_phase(uvm_phase phase)
		    int val;
		    forever
		    begin
			    get_port.get(val); // This is a blocking interface TLM method
			    		       // It blocks until it has
					       // something on this port.
			    'uvm_info("consumer" , $sformatf("receiving %4d", val), UVM_MEDIUM)
		    end

	    endtask

    endclass : consumer


    // Class Environment
    class env extends uvm_env;
	    producer p;
	    consumer c;
	    uvm_tlm_fifo #(int) f;  // tlm fifo initiation present inside library

	    // Initialization phase
	    function new(string name = "env");
		    super.new(name);
		    p = new("producer", this); // Always we pass string to associate the name and a
		    			       // pointer to associate the
					       // name of the parent class
		    c = new("consumer", this);
		    f = new("fifo", this);
		    $display("fifo put_export: %s", f.m_name);
	    endfunction
	    

	    // Connection Phase
	    function void connect_phase(uvm_phase phase);
		    p.put_port.connect(f.put_export);  // Producer put port to input analysis FIFO
		    c.get_port.connect(f.get_export);  // Consumer get port to output of TLM FIFO
	    endfunction


	    task run_phase(uvm_phase phase);
		    phase.raise_objection(this);
		    #1000;  // Thousand nanosecond 
		    phase.drop_objection(this);
	    endtask

    endclass

    // Main body of top_module test
    env e;

    initial 
    begin
	    e = new();
	    run_test();
	    // $finish;	    
    end

    endmodule // test




