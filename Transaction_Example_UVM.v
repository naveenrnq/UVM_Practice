class simple_trans extends uvm_transaction;

	rand data_t data;
	rand addr_t addr;
	rand enum {WRITE,READ} kind;
	constraint c1{addr < 16'h2000; }
	// ………..
endclass
