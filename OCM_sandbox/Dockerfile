FROM ubuntu:22.04

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y wget apt-transport-https ca-certificates curl gnupg

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

CMD ["bash"]
