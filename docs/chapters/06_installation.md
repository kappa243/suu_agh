# Clusters with the Application (AWS + Azure):
To deploy the application, you need to deploy all three services (website, shopapi, shopui) available in the repository https://github.com/devteds/demo-app-bookstore. Pay close attention to the config.yaml and secret.yaml files, which are part of the shopapi configuration. It is important to set the correct path and port for the database connection, which is located on another cluster (set the DB_HOST to the IP address of the database load balancer). To enable communication between the management cluster and the application clusters, create an ingress using Nginx. This configuration requires setting appropriate paths and ports for all three application services.

## Observability:
The observability configuration includes running Prometheus on the application clusters and exposing information on the appropriate port. This allows data to be collected on the main cluster and displayed to the user.

# Main Cluster (Google Cloud):
Inside the main cluster, the OCM hub, MySQL database server, and a load balancer need to be installed. To achieve this, a cluster has been configured within the Google Cloud Kubernetes engine.

## MySQL:
To deploy the MySQL server, create a PersistentVolumeClaim (PVC) and a deployment that will run the MySQL server in a container, configuring it using environment variables and mounting the PVC to the appropriate directory. The next step is to create a mysql-service that will expose the MySQL server as a LoadBalancer, enabling access to the database.

## OCMHUB:
...

## Observability:
Grafana is deployed on the main cluster, providing data from both the main cluster and the application clusters by retrieving data exposed by Prometheus. This setup allows users to monitor all clusters in one place, with all data presented and analyzed in a single service.


## Observability

### Prometheus (cluster)

- Create namespace
```
kubectl create namespace monitoring
kubectl get namespace monitoring
```

- Copy `prometheus-values.yaml` to the cluster

- Install Prometheus
```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

helm install prometheus prometheus-community/prometheus --namespace monitoring -f prometheus-values.yaml
```

- Check if Prometheus is running
```
kubectl get pods -n monitoring
kubectl get svc -n monitoring
```

There should be assigned external IP to the `prometheus-prometheus` service.

<br>

It should also be available at `http://localhost:9090` in your browser after port-forwarding.
```
kubectl port-forward svc/prometheus-server -n monitoring 9000:80
```

### Grafana (hub)

- Create namespace
```
kubectl create namespace monitoring
kubectl get namespace monitoring
```

- Copy `grafana-hub.yaml` to the hub cluster

- Install Grafana
```
kubectl apply -f grafana-hub.yaml -n monitoring
```

- Add each clusters' Prometheus as datasource
    - Go to `http://localhost:3000` in your browser after port-forwarding
    ```
    kubectl port-forward -n monitoring svc/grafana 3000
    ```
    - Login with `admin`/`admin`
    - Add Prometheus as datasource
        - Name: `prometheus-cluster1`
        - URL: `http://{cluster_address}:9090`
        - Access: `Server`
        - Save & Test
        - Repeat for `prometheus-cluster2`

