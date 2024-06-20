# deployment step by step

In this chapter there will be shown the logs and console outputs that appear during initialization proces.

## Clusters with applications

Before the OCM is used, we need to have working clusters. They are set up as in [chapter 6](06_installation.md). After initializing the application clusters on AWS and Azure we can see the services they provide. Note that, because the connections and load balancer is on the main cluster, none of the services have any external ip.

<img src="./../_img/services.png" alt="image" width="800" height="auto">

Here is the main cluster, that hosts database and loadbalancer. It is responsible for balancing load and it is the access point of the application.

<img src="./../_img/main_cluster.png" alt="image" width="800" height="auto">

## Setting up OCM

After creating clusters it is time to set up OCM.  The script "initialize_ocm.sh" will initialize hub cluster and then it will join it to the klusterlets that are passed as the script's arguments. Here is the output after a succesful execution.

<img src="./../_img/ocm_init.png" alt="image" width="800" height="auto">

After successful execution, the managed clusters can be displayed.

<img src="./../_img/clusters.png" alt="image" width="800" height="auto">

## Features to test

- One of the features that had been planned to be tested was the availability. OCM provides several strategies in case of cluster shutdown. Theoretically it is able to reroute traffic or automatically detect and trigger recovery process, all of that to keep services aveilable and minimalize downtime.
- OCM gives access to a quick way to setup multiple copies of clusters using Manifest. This feature would provide the application with a good scalability.
- Additionally OCM helps also with migrations to newer versions of the application. It can select clusters based on resource aveilability and deployment policies to also minimalize downtime of the services.

due to issues with OCM these features couldn't be tested properly.