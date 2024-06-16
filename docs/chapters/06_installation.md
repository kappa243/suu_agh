# Klastry z aplikacją (AWS + AZURE):

Aby uruchomić aplikację należy uruchomić deploymenty wszystkich trzech serwisów (webiste, shopapi, shopui), które znajdują się na repozytorium https://github.com/devteds/demo-app-bookstore. Należy zwrócić uwagę na pliki config.yaml oraz secret.yaml stanowiące część konfiguracji shopapi. Ważne, aby ustawić odpowiednią ścieżkę oraz port do połączenia z bazą danych, która znajduje się na innym klastrze (jako DB_HOST ustawiamy adres IP load balancera bazy danych). Aby umożliwić połączenie pomiędzy klastrem zarządzającym oraz klastrami aplikacyjnymi należy stworzyć ingress przy pomocy nginx. W ramach tej konfiguracji trzeba ustawić odpowiednie ścieżki i porty do wszystkich trzech serwisów aplikacji.

## Observability:
Konfiguracja observability obejmuje uruchomienie Prometheusa na klastrach aplikacyjnych, a także udostępnianie informacji na odpowiednim porcie. Dzięki temu dane będą gromadzone na główym klastrze i pokazywane użytkownikowi.

# Główny klaster (Google Cloud): 

 Inside the main cluster the OCM hub, MySQL database server and a load balancer have to be installed. In order to achieve it, a cluster has been configured within the Google Cloud Kubernetes engine.
 
## MySQL:
 
 
Aby uruchomić serwer MySQL należy utworzyć PersistentVolumeClaim (PVC) oraz deployment, który uruchomi serwer MySQL w kontenerze, konfigurując go przy użyciu zmiennych środowiskowych i montując PVC do odpowiedniego katalogu. Kolejnym krokiem jest stworzenie usługi mysql-service, która udostępni serwer MySQL jako LoadBalancer, umożliwiając dostęp do bazy danych.

## OCMHUB:
...

## Observability:

Na głównym klastrze uruchomiona zostaje grafana, która udostępnia dane zarówno z głównego klastra, jak i z klastrów aplikacyjnych poprzez pobranie udostępnianych przez Prometheusa danych. Dzięki takiemu rozwiązaniu użytkownik nie musi obserwować wszystkich klastrów oddzielnie, tylko ma wszystkie dane udostępnione i przeanalizowane w ramach jednego serwisu. 






Do wywalenia/ przeniesienia:
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

