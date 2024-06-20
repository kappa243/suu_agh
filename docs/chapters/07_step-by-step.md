# Deployment step by step

In this chapter the logs and console outputs that appear during initialization process willl be shown.

## Application clusters

Before the OCM is used, we tested the infrastructure deployed manually. They are set up as in [chapter 6](06_installation.md). After initializing the application clusters on AWS and Azure we can see the services they provide. Note that, because the main cluster is used as a proxy none of the services have any external IP address.

<img src="./../_img/services.png" alt="image" width="800" height="auto">

Here is the main cluster, that hosts database and loadbalancer. It serves as an access point to the application.

<img src="./../_img/main_cluster.png" alt="image" width="800" height="auto">

## Setting up OCM

After creating clusters it is time to set up OCM.  The script "initialize_ocm.sh" will initialize hub cluster and join klusterlets that are passed as the script's arguments. Here is the output after a succesful execution.

<img src="./../_img/ocm_init.png" alt="image" width="800" height="auto">

After successful execution, the managed clusters can be displayed.

<img src="./../_img/clusters.png" alt="image" width="800" height="auto">

## Placement and ManifestWork as key OCM features

### Placement

Placement in Open Cluster Management refers to the mechanism that determines where (which clusters) a specific resource or workload should be deployed. It defines the criteria and rules for selecting clusters from a pool of available clusters.

Key components of Placement:

- Placement Rule: A custom resource that defines the rules and constraints for selecting clusters. This could include criteria like cluster labels, cluster status, or other metadata.
- Placement Decision: The outcome of evaluating the placement rule, resulting in a list of clusters that match the criteria.


### ManifestWork

ManifestWork is a custom resource used to define and distribute Kubernetes resources to the selected clusters. It is essentially a package of Kubernetes manifests that need to be applied to the target clusters identified by the Placement process.

Key components of ManifestWork:

- Spec: Defines the set of Kubernetes manifests that need to be deployed. These could include ConfigMaps, Deployments, Services, etc.
- Status: Provides information about the deployment status of these manifests across the target clusters.

### How Do They Work Together
- Define a Placement Rule: Create a PlacementRule resource that specifies the criteria for selecting target clusters. This rule can consider various cluster attributes and statuses.
- Generate a Placement Decision: The Placement controller evaluates the PlacementRule and generates a PlacementDecision, listing the clusters that match the criteria.
- Create a ManifestWork: Define a ManifestWork resource that includes the Kubernetes manifests you want to deploy.
- Apply to Target Clusters: The ManifestWork resource is associated with the clusters identified in the PlacementDecision, and the specified manifests are deployed to those clusters.

At last we applied a manifestwork file onto the hub cluster to check if the application will be deployed on the application clusters. After shutting down the application manually on aws cluster and applying the ocm_appcluster.yaml file, all services have been successfully deployed. 

## Observability

After deploying Prometheus and Grafana on the cluster we were able to observe how the infrastructure works:

<img src="./../_img/grafana1.png" alt="image" width="800" height="auto">

<img src="./../_img/grafana2.png" alt="image" width="800" height="auto">

<img src="./../_img/grafana3.png" alt="image" width="800" height="auto">