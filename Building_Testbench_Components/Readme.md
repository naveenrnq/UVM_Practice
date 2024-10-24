# Example describing the sv file. For more look into the sv file.

DUT: - Let any DUT like SPI with APB interface
=> Let the bottom interface be SPI and the above interface be APB.
=> SQR is nothing but a sequencer which takes stimulus from the sequence and drives into DUT through driver.

All the components that operate in one interface is an Agent.

All the components that are not really tied to an interface like coverage monitor are at global level and connected at the env level class.

There is also a coniguration components which configures a certain attributes or parameters for that specific ABP or SPI interface.

It can be possible to have multiple env integrated in top-level env. 

![379915407-a366929c-f8e4-471b-a8d8-68c34a2c7dc6](https://github.com/user-attachments/assets/06d0809d-1baf-473c-a427-edf47692cabc)

# Example to show how a typical UVM's stimulus is generated

Sequence: - Dynamic object with a sequence of transactions or a sequence of stimulus at a higher abstraction that we want to drive to the DUT.

A sequence can consist of multiple sequence items.

Architecture of UVM

![image](https://github.com/user-attachments/assets/8cec9763-4a75-4659-bc80-180068e31b42)

# Static vs Dynamic components

=> Two types Static and Dynamic.

=> Left side is static and right side is dynamic.

![image](https://github.com/user-attachments/assets/d533d6c2-caf0-4183-9bcd-59685a234104)

Here we use directly Uvm_component

![image](https://github.com/user-attachments/assets/49bb0e24-eff0-4bb4-95ec-484665f4562d)

We will directly use the sequence. (Once in a while there can be a need of sequence_item)

![image](https://github.com/user-attachments/assets/997ffc93-ab5b-425b-b79c-27312b745d43)

# Avialable UVM Components

![image](https://github.com/user-attachments/assets/bc9f23ac-efca-4d40-8654-417ea24077ea)






