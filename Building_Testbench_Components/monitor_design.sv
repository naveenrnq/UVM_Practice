// What is UVM monitor?
// Extract signal level information and translates to objects/events or high
// level information.
// Passes this information to ther Test bench components throughTLM
// connections.
// Usually passes information to coverage collectors or scoreboards using
// analysis ports/exports.
//

/* 
  How to create a monitor
  => Derive a monitor from uvm_monitor base class.
  => Implement the logic to monitor the signal level information(using a virtual interface).
  => Translates signal level information to transaction
  => Implement an analysis port to which monitored transactions are to be written out.
  => All other component that needs this information in the testbench nned to connect to this analysis port.
*/

class master_monitor extends uvm_monitor;
	virtual bus_if xmi; // System virtual interface.
	
	// Interface level basic checks
        bit checks_enable = 1; // controls checking in monitor and interface.
	bit coverage_enable = 1; // Controls coverage in monitor and interface.
	
	// Most important to declare analysis port
	uvm_analysis_port #(simple_item) item_collected_port;

	
	event conv_transaction; // event transactions to trigger covergroups
	

	protected simple_item trans_collected;

	// Implementations of component that a class needs to do

	// UVM configuration or initialization related information
	uvm_components_utils_begin(master_monitor)
	 `uvm_field_int(checks_enable, UVM_ALL_ON)
	 `uvm_field_int(coverage_enable, UVM_ALL_ON)
	uvm_component_utils_end


	// If we want to monitor certain interface level information
	// Eg read/write, memory bus interface
	// We can get directly the coverage in the monitor to see what kind of
	// read transactions or write transactions happening inside the
	// interface
	covergroup cov_trans @conv_transaction;
		options.per_instance = 1;
		//coverage bins definition
	endgroup : cov_trans


	// Constructer for monitor
	function new (string name, uvm_component parent);
		super.new(name, parent); // calling base class constructer
		cov_trans = new();
		cov_trans.set_inst_name({get_full_name(), ".cov_trans"});
		trans_collected = new();
		item_collected_port = new("item_collected_port", this);
	endfunction : new

	// Typically in the run phase, which is what gets called every
	// simulation phase as the test starts
	// Eg Implementing threads which keeps collecting transactions
	virtual task run_phase(uvm_phase phase);
          fork
		  collect_transactions();
	  join
        endtask : run  // Either do this or run forever method in the run phase
	

	virtual protected task collect_transactions();

		forever begin @(posedge xmi.sig_clock);

		// collect the data from the bus into trans_collected.
	
			if(checks_enable)
			perform_transfer_checks();
	
			if(coverage_enable)
			perform_transfer_coverage();
		        
		        // finally do write to analysis port to that write
			// transaction
	        	items_collected_port.write(trans_collected);


		end

	endtask : collect_transactions


	virtual protected fuction void perform_transfer_coverage();
		-> cov_transaction;
	endfunction : perform_transfer_coverage



	virtual protected function void perform_transfer_checks();
		//perform data checks on trans_collected
	endfunction : perform_transfer_checks


endclass


        













