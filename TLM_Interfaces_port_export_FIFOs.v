/* Lets take an example where producer wants to produce some transaction and
   consumer wants to consume that transaction.
   
   Two ways to transfer that transaction: -
   1. Producer doing a put the transaction into the consumer.
   2. Consumer pulls from the producer directly into itself. */

 
// 1. Produce doing put the transaction into the consumer.
   
   // Producer side code
   class producer extends uvm_component;
     uvm_blocking_put_port #(simple_trans) put_port; // Suppose I want to communicate a simple transaction which
     						     // is parameterized with
						     // a port name as
						     // put_port
						     
     function new(string name, uvm_component parent); // It is a constructer for a class
	     put_port = new("put_port", this); // Creating an instance of this put port and assign 
	     				       // this as name for that.
					       // Here put_port is the name
					       // and this is the parent.
					       // "this" indicated that the
					       // parent of this put_port is
					       // producer
	//...
     endfunction

     // Here we define what the producer class does
     virtual task run(); 
         simple_trans t;
	 for(int i=0; i<N; i++) begin
		 // Here we aregenerating a transaction like
		 // create an instance of the transaction do randomization
		 // and then
 	 	 put_port.put(t); // Now put some transaction on this put port
     end
     endtask
    endclass

    // Consumer side code
    class consumer extends uvm_component;
     uvm_blocking_put_imp #(simple_trans, consumer) put_export;
     // ...
     task put(simple_trans t);
	     case(t.kind)
		     READ:  // Do read.
		     WRITE: // Do write.
 	     endcase
     endtask
    endclass


// 2. Consumer pulls from the producer directly into itself. (Also called
// pull_port or get_port)
   
   // Consumer Side
   class get_consumer extends uvm_component;
    uvm_blocking_get_port #(simple_trans) get_port; // it is parameterized to simple transaction
    function new(string name, uvm_component parent); // Constructor consumer 
	   get_port = new("get_port" , this); // "get_port" is string that identifies the port.
	   				      // "this" is parent class 
	   //....
    endfunction
    virtual task run();
      simple_trans t;
      for(int i=0; i<N; i++) begin
	      //Generate t.
	      get_port.get(t); // blocking task that blocks the port unless we get that type of transaction
	     		       // This port will get blocked unless producer
			       // will be able to send some information
      end
    endtask


    // Producer Side
    class get_producer extends uvm_component;
     uvm_blocking_get_imp #(simple_trans, get_producer) get_export; // Blocking get_export implementation
     								    // 
     //...
     task get(output simple_trans t); // create a transaction
	     simple trans tmp = new(); // calls new of that transaction
	     // Assigns value to temp and do randomization
	t = tmp;
     endtask
    endclass


 

// The put or get will block the channel to one transaction at a time that we
// doesnt want
// We want multiple transactions that needs to be communicated into.
// That problem is solved by TLM FIFO which is provided by UVM
// This is to queue up multiple transactions.
// Instead of connectiong port and export now we use TLM FIFO in between.
//
//
// Now we have initiated the producer and consumer.
// Here we see how to connect the producer and the consumer
//


class my_env extends uvm_env;
  //...
  virtual function void connect(); // connections happen using the connect method
   // component.port.connect (target.export);
   producer.blocking_put_port.connect(fifo.put_export); 
   get_consumer.get_port.connect(fifo.get_export); // if we want to directly connect then instead of fifo.get_export
   						   // we will be using
						   // get_producer.get_export
   //...
  endfunction
endclass
