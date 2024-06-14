kubectl apply -f services/website/deploy.yaml
kubectl apply -f services/website/service.yaml

kubectl apply -f services/shopapi/config.yaml
kubectl apply -f services/shopapi/secret.yaml

kubectl create -f services/shopapi/job-dbc.yaml

kubectl apply -f services/shopapi/deploy.yaml
kubectl apply -f services/shopapi/service.yaml


kubectl apply -f services/shopui/deploy.yaml
kubectl apply -f services/shopui/service.yaml

