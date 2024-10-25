//Sequencer and driver are connected using TLM port
//Driver pulls data from Sequencer using get_next_item();
//Driver has a sequence_item_port that is connected to a sequence_item_export
//in sequencer.
//
//TLM port put_port and get_port between sequencer and driver inside the base
//class.
//
//Agent component: - Components that collect all the components across
//specific interface.
//
//Connect method of Agent is actually where we really connect the sequencer
//and driver because at this level both of the component would be visible
//
//Connection method where we really connect the phase with the agent
//


function void connect_phase(uvm_phase phase);
	if(m_cfg.active == UVM_ACTIVE) // indicates its an active agent
	begin
		m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
		m.driver.rsp_port.connect(m_sequencer.rsp_export);
		m_driver.vif = cfg.vif;
	end
endfunction


// Basic interaction
//
// Main driver loops calls get_next_item()
// =>Can also use try_next_item()
//
// item_done() signals back to the sequencer
//
task run_phase(uvm_phase phase);
	forever begin
		// Get the next item into sequencer
		seq_item_port.get_next_item(s_item);
		//Execute the item
		drive_item(s_item);
		seq_item_port.item_done(); // consume the request
	end
endtask : run 


//Sending response back
//Suppose the scenario where the driver wants to send response back
//Eg Assuming you send a read transaction and want to generate a following
//read based on original data (Simple read operation from memory)
//Two ways of responding back
//=> Modify certain feilds in the same transaction send from sequencer to
//driver.
//=> Use seperate response port to send responses
//
//
//Using same port: -
//=>seq_item_port.item_done(rsp);
//=>seq_item_port.put_response(rsp);
//
//Using response port
//=>rsp_port.write(rsp);
//
//Notes: - rsp should of the response class type as identified 
//For copying sequence id from request to response use rsp.set_id_info(req).
