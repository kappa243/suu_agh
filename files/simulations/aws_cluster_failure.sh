nodes=$(kubectl get nodes -o name)
for node in ${nodes}; do
    echo "==== Shutting down $node ===="
    ssh $node sudo shutdown -h now
done