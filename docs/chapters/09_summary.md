# Summary

The primary objective of this project was to investigate the features and capabilities of Open Cluster Management (OCM), a solution designed to facilitate the management of multiple Kubernetes clusters. The goal was to understand how OCM can simplify the management, scaling, and operation of multi-cluster environments.


## Methodology

* **Literature Review and Initial Setup:**

    + Reviewed official OCM documentation and related resources to understand core concepts.
    + Set up the necessary infrastructure, including multiple Kubernetes clusters on different cloud providers (Google Cloud, AWS, and Azure).
    + Installed and configured OCM components on a central hub cluster.

* **Feature exploration:**
    + Cluster registration: Explored the process of registering multiple clusters to the hub. This involved generating and using hub tokens, configuring kubeconfigs, and dealing with certificate management.
    + Application Lifecycle Management: Investigated how OCM handles application deployments, updates, and rollbacks across clusters.
    + Observability and Monitoring: Assessed the observability features provided by OCM, such as metrics collection, logging, and alerting mechanisms.

## Findings

* We have successfully managed to create an OCM setup with one hub cluster located on Google Cloud and two klusterlets both on AWS and Azure.

* We prepared .yaml files for OCM hub for which leverages placement rules for application [deployment on managed clusters](https://github.com/open-cluster-management-io/multicloud-operators-subscription?tab=readme-ov-file#multi-cluster-deployment) however we stumbled upon several issues and did not success.

## Challenges and limitations

* Certificate Management: Handling TLS certificates and ensuring their validity was a recurrent challenge. Automating this process is crucial for smoother operations.

* All demos of OCM features were conducted and showcased in kind (kubernetes in docker). When switching to actual cloud providers unexpected issues started popping which were not mentioned in docs.

## Conclusion

Open Cluster Management offers a comprehensive solution for managing multiple Kubernetes clusters, providing significant improvements in operational efficiency, security, and observability. While there are challenges, particularly with the initial setup and certificate management, these issues stem from OCM being in an early development stage. As OCM matures, we anticipate these hurdles will be addressed. With proper planning and automation, current issues can be mitigated. Despite these early-stage challenges, OCM is a promising tool for organizations looking to scale their Kubernetes deployments across multiple environments and cloud providers.