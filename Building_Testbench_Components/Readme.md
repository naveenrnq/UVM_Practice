# Example describing the sv file. For more look into the sv file.

DUT: - Let any DUT like SPI with APB interface
=> Let the bottom interface be SPI and the above interface be APB.
=> SQR is nothing but a sequencer which takes stimulus from the sequence and drives into DUT through driver.

All the components that operate in one interface is an Agent.

All the components that are not really tied to an interface like coverage monitor are at global level and connected at the env level class.

There is also a coniguration components which configures a certain attributes or parameters for that specific ABP or SPI interface.

It can be possible to have multiple env integrated in top-level env.

+-----------------------------+
|           test              |
|  +-----------------------+  |
|  |         env           |  |
|  |  +-----------------+  |  |
|  |  |  scoreboard     |  |  |
|  |  +-----------------+  |  |
|  |  |  +-------------+ |  |  |
|  |  |  | configuration| |  |  |
|  |  |  | apb config   | |  |  |
|  |  |  | spi config   | |  |  |
|  |  |  +-------------+ |  |  |
|  |  +-----------------+  |  |
|  |  | coverage monitor |  |  |
|  |  +-----------------+  |  |
|  |  |  +-------------+ |  |  |
|  |  |  | APB Agent   | |  |  |
|  |  |  | +---------+ | |  |  |
|  |  |  | | monitor | | |  |  |
|  |  |  | +---------+ | |  |  |
|  |  |  | | SQR     | | |  |  |
|  |  |  | +---------+ | |  |  |
|  |  |  | | driver  | | |  |  |
|  |  |  | +---------+ | |  |  |
|  |  |  +-------------+ |  |  |
|  |  +-----------------+  |  |
|  |  |  +-------------+ |  |  |
|  |  |  | SPI Agent   | |  |  |
|  |  |  | +---------+ | |  |  |
|  |  |  | | monitor | | |  |  |
|  |  |  | +---------+ | |  |  |
|  |  |  | | SQR     | | |  |  |
|  |  |  | +---------+ | |  |  |
|  |  |  | | driver  | | |  |  |
|  |  |  | +---------+ | |  |  |
|  |  |  +-------------+ |  |  |
|  |  +-----------------+  |  |
|  +-----------------------+  |
+-----------------------------+
            |
            |
            v
+-----------------------------+
|            DUT              |
| (SPI with APB interface)    |
+-----------------------------+


# Example to show how a typical UVM's stimulus is generated

Sequence: - Dynamic object with a sequence of transactions or a sequence of stimulus at a higher abstraction that we want to drive to the DUT.

A sequence can consist of multiple sequence items.

Architecture of UVM

![image](https://github.com/user-attachments/assets/8cec9763-4a75-4659-bc80-180068e31b42)

# Simplified UVM inheritance diagram

=> Two types Static and Dynamic.

=> Left side is static and right side is dynamic.

![image](https://github.com/user-attachments/assets/d533d6c2-caf0-4183-9bcd-59685a234104)



