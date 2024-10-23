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

