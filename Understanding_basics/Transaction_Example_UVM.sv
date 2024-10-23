class simple_trans extends uvm_transaction; // Any transaction that we need to 
					    // define needs to be from either OVM or UVM transaction
	
	//Information needed for simple transaction					    
	rand data_t data; // we need data information
	rand addr_t addr; // We need address information
	rand enum {WRITE,READ} kind; // Select the operation. i.e. write or read.
	constraint c1{addr < 16'h2000;} // It is contraint. Simply a verilog construct. 
					// This constraint is limiting the
					// addr to be always be less than
					// 16'h2000
	// ………..
endclass
