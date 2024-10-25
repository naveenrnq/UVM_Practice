// Agent Design
//
// Agent is collection of group of uvm_component focused around a specific
// pin-level interface
//
// Typically initiates driver , sequencer, monitor and connects them all
// together.
//
// Also have a configuration components
//
// Multiple agents can be used for multiple DUT interfaces which has different
// protocol.
// Agents can be reused for similar interfaces.
// Components within an agent can be configured active/passive.
// => Active: - Contains active components like driver, sequencer which are
// active during simulations.
// => Passive: - Contains only passive components like monitors which does'nt
// drive any stimulus.
//
// For active it is driving DUT but for passive it only monitors.
//
// Enironments can also be active and passive.



class simple_agent extends uvm_agent;


  // This is used to define as Agen active or passive
  uvm_active_passive_enum is_active;
  // Constructor and UVM automation macros
  simple_sequencer sequencer;  // Agent will initiates sequencer driver and monitor
  simple_driver driver;
  simple_monitor monitor;
 
  // Use build() phase to create agents's subcomponents.
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase) // Will call the base class build
    // We always define monitor phase irrespective of active or passive
    monitor = simple_monitor::type_id::create("monitor",this);
    // If agen is active type then define all these below values
    if (is_active == UVM_ACTIVE) begin
      // Build the sequencer and driver.
      sequencer = simple_sequencer::type_id::create("sequencer",this);
      driver = simple_driver::type_id::create("driver",this);
    end
  endfunction : build_phase

  //Use connect phase to connect components together
  virtual function void connect_phase(uvm_phase phase);
    if(is_active == UVM_ACTIVE) begin
      driver.seq_item_port.connect(sequencer.seq_item_export); // connect your driver sequence item port to sequence export
    end
 endfunction : connect_phase

endclass : simple_agent
