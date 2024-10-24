// There are two types of testbench components
// Static and Dynamic
//
// Static Components- forms the testbench hirarchy
// => Remains throughout the simulation.
// => Every component will be part of static hirarchy.
// => Eg Drivers, Checker, Monitor, Scoreboard.
//
// Dynamic Components- Forms the stimulus
// => Are generated dynamically are used and garbage collected when
// dereferenced.
// => Eg Transactions, Sequences
//
// We have several components like drivers, monitors, scoreboard and DUTs that
// can have several interfaces and above it we can have component sitting at
// all of these interfaces.
//
// This means in UVM or OVM we collect the multiple components into another
// higher level of hirarchy. This higher level of hirarchy is collectively
// divided into-
// => the env (short for environment)
// => the agent
//
// Env -
// => Environment class that encapsulates all testbench components.
// => All components that are part of the environment.
// => Group all agents to this env class.
//
// Agent -
// => A group of testbench components (monitor/driver etc) that all operate on
// a specific interface to DUT.
//
// 
