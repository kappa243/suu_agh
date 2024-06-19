# Application testing

In this section, the infrastructure of the application has been tested and impact of network and cluster faults on the behavior has been explored. By simulating various scenarios, we gained insights into potential points of failure. 

## Traffic simulation

Locust library has been used to simulate traffic in the network. We used previosly desribed observability setup to check if the load balancer works correctly and to analyse how the application works in standard flow. Here is a python script used to generate requests: 

```
from locust import HttpUser, task, between

class QuickstartUser(HttpUser):
    wait_time = between(1, 2.5)

    @task
    def hello_world(self):
        self.client.get("34.70.163.223/")
        self.client.get("34.70.163.223/shop")
```

We used grafana to analyze the dashboards and metrics coming from the clusters and to verfify that the load balancer works correctly.

## Cluster failure simulation

An approach desribed in https://open-cluster-management.io/scenarios/migrate-workload-with-placement/ has been used to simulate cluster failure. We expect appropriate cluster maintenance/failure status detection and workload migration to another cluster.
Script used to simulate cluster failure:

```
nodes=$(kubectl get nodes -o name)
for node in ${nodes}; do
    echo "==== Shutting down $node ===="
    ssh $node sudo shutdown -h now
done
```