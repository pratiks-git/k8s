#!/bin/bash
# Script to clean up Kubernetes Observability Demo on AWS

set -e

export AWS_PROFILE="default"

echo "===== Cleaning up Kubernetes Observability Demo on AWS ====="

# Delete the demo application
echo "Deleting demo application..."
kubectl delete namespace demo-app --ignore-not-found

# Delete monitoring components
echo "Deleting monitoring components..."
kubectl delete namespace elk --ignore-not-found

# Delete the EKS cluster
echo "Deleting EKS cluster..."
eksctl delete cluster --name elk-demo-cluster --region us-east-1
