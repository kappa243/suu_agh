## Running OCM minimal example:

 Those steps have been conducted on ubuntu 22.04.

- Ensure docker is installed:  
```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list
apt-get update && \

apt-get install -y docker-ce docker-ce-cli containerd.io
```
- Ensure go is installed:
```
  export GO_VERSION=1.22.2
  wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz && \
  tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz && \
  rm go${GO_VERSION}.linux-amd64.tar.gz
  export PATH=$PATH:/usr/local/go/bin
```
- Ensure k8s is installed:
```
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list
chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg && \
chmod 644 /etc/apt/sources.list.d/kubernetes.list
apt-get update && \
apt-get install -y kubectl
kubectl version --client
```
- Install kustomize:
```
  GOBIN=/usr/local/go/bin/ GO111MODULE=on go install sigs.k8s.io/kustomize/kustomize/v5@latest
```
- Install kind:
```
go install sigs.k8s.io/kind@v0.22.0
export PATH=$PATH:/root/go/bin
```

- Install OCM clusteradm CLI tool:
```
curl -L https://raw.githubusercontent.com/open-cluster-management-io/clusteradm/main/install.sh | bash
```

- Create aws, azure and google cloud acocunts, install appropriate CLI's by following these guides:

AWS: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

Azure: https://learn.microsoft.com/en-us/cli/azure/install-azure-cli 

Google Cloud: https://cloud.google.com/sdk/docs/install

For minimal example (joining 2 worker clusters to 1 hub) you can launch this script:

```
#!/bin/bash

cd $(dirname ${BASH_SOURCE})

set -e

hub=${CLUSTER1:-hub}
c1=${CLUSTER1:-cluster1}
c2=${CLUSTER2:-cluster2}

hubctx="kind-${hub}"
c1ctx="kind-${c1}"
c2ctx="kind-${c2}"

kind create cluster --name "${hub}"
kind create cluster --name "${c1}"
kind create cluster --name "${c2}"

echo "Initialize the ocm hub cluster\n"
clusteradm init --wait --context ${hubctx}
joincmd=$(clusteradm get token --context ${hubctx} | grep clusteradm)

echo "Join cluster1 to hub\n"
$(echo ${joincmd} --force-internal-endpoint-lookup --wait --context ${c1ctx} | sed "s/<cluster_name>/$c1/g")

echo "Join cluster2 to hub\n"
$(echo ${joincmd} --force-internal-endpoint-lookup --wait --context ${c2ctx} | sed "s/<cluster_name>/$c2/g")

echo "Accept join of cluster1 and cluster2"
clusteradm accept --context ${hubctx} --clusters ${c1},${c2} --wait

kubectl get managedclusters --all-namespaces --context ${hubctx}
```
