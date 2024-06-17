# Application testing

In this section, the infrastructure of the application has been tested and impact of network and cluster faults on the behavior has been explored. By simulating various scenarios, we gained insights into potential points of failure. 

## Traffic simulation

Approach:

... has been used to simulate traffic in the network. We used previosly desribed observability setup to check if the load balancer works correctly and to analyse how the application works in standard flow.

Observations:

screeny

## Cluster failure simulation

Approach:

An approach desribed in https://open-cluster-management.io/scenarios/migrate-workload-with-placement/ has been used to simulate cluster failure. We expect appropriate cluster maintenance/failure status detection and workload migration to another cluster.

Observations:

screeny