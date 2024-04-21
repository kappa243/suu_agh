# Theoretical background/technology stack

## What is OCM?

**Open Cluster Management (OCM)** is a community-driven project under the Cloud Native Computing Foundation (CNCF) that simplifies the management of Kubernetes clusters across numerous environments. It offers a comprehensive solution for managing Kubernetes clusters across various environments, offering a scalable, secure, and extensible platform for cluster lifecycle, application management, and governance. Community-driven approach and modular architecture make it a valuable tool for organizations looking to simplify and enhance their multi-cluster and multi-cloud Kubernetes management strategies.

## Key features

### Architecture

The architecture of OCM is built around a **hub-agent model**, inspired by the original "hub-kubelet" pattern from Kubernetes. This model consists of a hub cluster, which runs the multi-cluster control plane of OCM, and klusterlets, which are the clusters managed by the hub. The hub cluster is a lightweight Kubernetes cluster hosting fundamental controllers and services, while klusterlets, also known as managed or spoke clusters, actively pull the latest prescriptions from the hub cluster and reconcile the physical Kubernetes cluster to the expected state. Klusterlets work independently and autonomously. This leads to a minimal reliance on the hub cluster's availability.
<div align="center">

![](https://raw.githubusercontent.com/open-cluster-management-io/OCM/main/assets/ocm-arch.png)
<sub>Architercture visualization from official OCM site.</sub>
</div>

### Functionalities

OCM's core functionalities include **cluster lifecycle management**, **application lifecycle management**, and **governance**, **risk**, and **compliance** (**GRC**) across clusters. Cluster lifecycle management involves registering clusters and managing their lifecycle, while application lifecycle management focuses on deploying, upgrading, and configuring applications across clusters. GRC uses prebuilt security and configuration controllers to enforce policies across clusters, ensuring compliance and risk management.

### External integrations

The project **integrates with other open-source projects** to enhance its capabilities, such as Submariner for networking connectivity, Clusternet for orchestration, and KubeVela for application delivery. These integrations allows OCM to offer a comprehensive solution for managing Kubernetes clusters across multiple environments.
