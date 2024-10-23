 
classmy_env extends ovm_env;
 
 class tr extends ovm_transaction
  // some definition
 endclass
 
 //Port
 class initiater extends ovm_component; // initiater
   ovm_put_port #(tr) pport; // put port with parameterized type transaction
   virtual task run();
   // ...
    pport.put(tr1); // Putting a transaction on specific port
    		    // This put will be actually translated into target class
		    // where we actually define what should that put should
		    // actually translate into
   // ...
   endtask
 endclass  

// function to connect port to export
virtual function void connect();
 initiator.pport.connect(target.pxport);
endfunction
 
 //Export
 class target extends ovm_component; // Target components
   ovm_put_imp #(tr.target) pxport;
   virtual task put(tr);
  //...
  endtask
 endclass

endclass
