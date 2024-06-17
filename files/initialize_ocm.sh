#!/bin/bash

if [ "$#" -lt 2 ]; then
  echo "Usage: $0 <hub_context> <klusterlet_context_1> [<klusterlet_context_2> ...]"
  exit 1
fi

hub_context="$1"
shift 

clusteradm init --wait --context "$hub_context"
if [ $? -ne 0 ]; then
  echo "Failed to initialize hub cluster: $hub_context"
  exit 2
fi

joincmd=$(clusteradm get token --context ${hub_context} | grep clusteradm)

for klusterlet_context in "$@"; do
  echo "Attempting to join klusterlet with context: $klusterlet_context"
  
  $(echo $joincmd --wait --context $klusterlet_context | sed "s/<cluster_name>/$klusterlet_context/g")

  if [ $? -ne 0 ]; then
    echo "Failed to join klusterlet: $klusterlet_context"
    exit 3
  fi
done

clusteradm accept --context ${hub_context} --clusters "$@"
echo "All klusterlets have been successfully joined."
