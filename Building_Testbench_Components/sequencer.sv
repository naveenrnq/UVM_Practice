// Sequencer 
// => Sequencer is a component that passes the stimulus data from
// generator(Sequence) to a driver.
// => Multiple sequences can be trying to send sequence items to driver.
// Sequencer arbiterates between them.
// simple_item will be passed to driver
// simple_resp special case where we need response from driver as well

class simple_sequencer extends uvm_sequencer #(simple_item, simple_rsp);
	`uvm_comonent_utils(simple_sequencer);
	function new(input string name, uvm_component parent = null)
		super.new(name, parent);
	endfunction
endclass : simple_sequencer
