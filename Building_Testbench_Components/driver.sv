// Driver -
//
// Drives data items to the DUT following the interface protocol.
//
// It gets items from the sequencer for execution.
//
// The UVM class library provides the uvm_driver base class from which all the
// driver classes should be extended, either directly or indirectly.
//
// The driver has run() method that defines its operation, as well as a TLM
// port through which it communicates with sequencer.
//
//
//
 
// Simple driver which is extension of uvm_driver which is parameterized
// Driver is parameterized that means driver basically accepts transactions of
// type simple_items from the sequencer and translates that it into actual pin
// level information and drives DUT
class simple_driver extends uvm_driver #(simple_item);
	simple_item s_item; // driver takes a sequence item which is defined as simple item
	                    // defined by user derived from base class
			    // uvm_sequence item
	virtual dut_if vif; // Virtual interface to describe all the interface level signals of the
			    // DUT
			    // Used by driver to actually drive the signals to
			    // the DUT
	
	// UVM Automation macros for general components
        `uvm_component_utils(simple_driver) // We need to register any of the testbench component 
					    // within the UVM factory which
					    // can be done using those
					    // `uvm_component_utils
	//constructer which exist in base uvm_driver class
	function new (string name = "simple_driver" , uvm_component parent);
		super.new(name,parent);
	endfunction : new


	/* All the component has a build_phase run_phase methods:
	   Building the component is done in the build_phase
	   uvm_config_db: - uvm config database which manages all the configurations of env */
	// Build phase
	function void build_phase(uvm_phase phase);
		string inst_name;
		super.build_phase(phase);
		if(!uvm_config_db#(virtual dut_if)::get(this,"","vif",vif))
		begin
			`uvm_fatal("NOVIF", {"virtual interface must be set for:", get_full_name(),".vif"});
		end
        endfunction : build_phase 
	
	//run_phase
	task run_phase(uvm_phase phase);
		/* 
		This is where the actual functionality and work are performed by the driver. 

		In this section, the driver operates within an infinite loop. Its main task is 		to retrieve an item from the sequence defined as "sequence item bought." This sequence 		is defined in the base class, UVM Driver, which is parameterized by type. 

		In this case, the parameter of the UVM driver is a simple item. The driver incl		udes a port with a method called `get_next_item`, which is a blocking call. Whenever a		n item is pushed from the sequencer, the driver becomes unblocked and retrieves the s		equence item. 

		Thus, within the infinite loop, the driver continues to wait until it receives 		a new item. Once it gets an item, it calls a method named `driver_item`.
		*/
		forever begin
			// get the next data item from sequencer (may block).
			seq_item_port.get_next_item(s_item);
			// Execute the item
			drive_item(s_item);
			seq_item_port.item_done(); // consume the request
		end
	endtask

	// here put the exact logic APB interface, PCIe interface
	// Information will be converted to pin level information
	task drive_item(input simple_item item);
		// Add your logic here
	endtask : drive_item

endclass : simple_driver




