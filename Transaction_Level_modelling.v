// Transaction Level Modelling

// Transaction Level Modelling is an approach of multiple processes
// communicating with each other by sending transaction back and forth through
// channels.

// Channel can be anything take example here as a FIFO. i.e. to get
// information and pass information.

/* 
   Example: Let there be two components 
   Producer => Consumer

   Instead of modelling all the information that passes through producer and consumer at the low level. We can group    all that information in the form of a transaction and use some channel/queue to pass this transaction between        producer and a consumer. This is TLM 
*/

 

/* 
  
   Abstracts time
   => Reduces the number of activation of process. e.g. Saves times by directly jumping to the 10th clock cycle            (transaction) instead of following classical approach of passing data cycle by cycle.
   => RTL evaluation of nets/signals vs evaluations of transactions.


   Abstracts data
   => Form transaction objects instead of bit by bit details.

   Abstract functions
   => Implement functionality with function/process rather than with real registers or circuit.

*/

/*
  TLM is the basis for modularity and reuse in OVM/UVM.
  TLM is all aboutcommunication through method calls.
  => A TLM port specifies the "API" to be used.
     (Function name that needs to be called when some transaction over a channel is needed.)
  => A TLM export supplies the implementation of the methods.
     (Implementation of that specific channel by which communication actually happens)
  Communication are between ports/exports, not components.
  Transactions are nothing but object.
  Port and exports are parameterized by the transaction type being communicated.
*/




