// Previously all TLM ports were one to one connections.
// OVM/UVM base library also provides analysis_port.
//
// Analysis port supports one to many connections
// Used by coverage collectors and score_boards.
//
// The analysis_port contains a list of analysis_exports that are connected to
// it. Similarly that port and export needs to be connected.
//
// When the component calls analysis_port.write(), the analysis_port cycles
// through the list and calls the write() method of each connected export.
//
// TLM Ports are used for point to point connections whereas Analysis port can
// be connected to many.
//
//                        AP     ConnectedTo  Analysis_Export
//                        --                  --exp1
//                        --                  --exp2
//   AP.write(txn) ==>    --                  --exp3
//                        --                  --exp4
//                        --                  --exp5
//                        --                  --exp6
//
//   Just like a broadcast to all the analysis port
//
