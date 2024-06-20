# Application testing

In this section, the infrastructure of the application has been tested and impact of network and cluster faults on the behavior has been explored. By simulating various scenarios, we gained insights into potential points of failure. 

## Traffic simulation

Requests library has been used to simulate traffic in the network. We used previosly desribed observability setup to check if the load balancer works correctly and to analyse how the application works in standard flow. Here is a python script used to generate requests: 

```
import requests

def get_data_from_api(url):
    response = requests.get(url)

    if response.status_code == 200:
        data = response.json()
        return data
    else:
        print(f"Failed to retrieve data: {response.status_code}")
        return None

api_url = "http://34.42.212.39/api/books"

data = get_data_from_api(api_url)

if data:
    print("Data retrieved successfully:")
    print(data)
else:
    print("No data retrieved.")
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