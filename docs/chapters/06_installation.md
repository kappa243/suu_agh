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

