# Case study concept description

We highlight following key features of OCM that we find worth investigating within scope of this case study:<br>
* Ensuring safe cluster authorization is crucial in order to meet some compliance requirements.
    + Investigate cluster registering aka "double opt-in handshaking"
* Dynamic resource management and scalability. Cloud services usually do not have constant demand levels. Dynamically allocating resources due to spikes in traffic is critical.
    + Make use of <b>Placement API</b> in order to dynamically select a set of managed clusters and deploy workloads to these clusters
* Availability and fault recovery
    + Identify behavior of klusterlets during simulated hub maintenance/termination.
    + Make use of <b>Placement API</b> in order to migrate application to another cluster automatically when one cluster is down or migrate it manually for maintenance purposes.