#dockerfile for setting up DinD OCM for testing purposes
FROM ubuntu:22.04

#update system and install necessary packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y wget apt-transport-https ca-certificates curl gnupg software-properties-common lsb-release

#install Docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list
RUN apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io

#install go
ENV GO_VERSION=1.22.2
RUN wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz && \
    rm go${GO_VERSION}.linux-amd64.tar.gz
ENV PATH=$PATH:/usr/local/go/bin

#install k8s
RUN curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
RUN echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list
RUN chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg && \
    chmod 644 /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update && \
    apt-get install -y kubectl
RUN kubectl version --client

#install kustomize
RUN GOBIN=/usr/local/go/bin/ GO111MODULE=on go install sigs.k8s.io/kustomize/kustomize/v5@latest

#install kind
RUN go install sigs.k8s.io/kind@v0.22.0
ENV PATH=$PATH:/root/go/bin

#install clusteradm CLI tool
RUN curl -L https://raw.githubusercontent.com/open-cluster-management-io/clusteradm/main/install.sh | bash

#setup hub and managed cluster
# RUN curl -L https://raw.githubusercontent.com/open-cluster-management-io/OCM/main/solutions/setup-dev-environment/local-up.sh | bash

COPY container_startup.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh
ENTRYPOINT ["/usr/local/bin/start.sh"]
CMD ["bash"]
