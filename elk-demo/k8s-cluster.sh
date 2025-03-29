#!/bin/bash
# Script to set up a Kubernetes Observability Demo on AWS

set -e

export AWS_PROFILE="default"

echo "===== Setting up Kubernetes Observability Demo on AWS ====="

# Prerequisites check
echo "\nChecking prerequisites..."
command -v aws >/dev/null 2>&1 || { echo "AWS CLI required, installing..."; pip install awscli; }
echo "AWS CLI: Done"
command -v eksctl >/dev/null 2>&1 || { echo "eksctl required, installing..."; curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp && sudo mv /tmp/eksctl /usr/local/bin; }
echo "eksctl: Done"
command -v kubectl >/dev/null 2>&1 || { echo "kubectl required, installing..."; curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && chmod +x kubectl && sudo mv kubectl /usr/local/bin/; }
echo "kubectl: Done"
command -v helm >/dev/null 2>&1 || { echo "helm required, installing..."; curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash; }
echo "helm: Done"


# Creating demo cluster
echo "Creating demo cluster with eksctl..."
echo "Using cluster config as below"
cat cluster-config.yaml

eksctl create cluster -f cluster-config.yaml

echo "Cluster created successfully!"
kubectl get nodes

#Installing EBS driver as elasticsearch needs storage for storing the logs
kubectl apply -k "github.com/kubernetes-sigs/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable/ecr/"



#Create monitoring stack with namespace elk
kubectl create namespace elk

#Install elasticsearch
helm install elasticsearch elastic/elasticsearch -f elasticsearch-values.yaml  --namespace elk

#Install filebeat
helm install filebeat elastic/filebeat -f filebeat-values.yaml  --namespace elk

#Install Logstash with helm
helm install logstash elastic/logstash -f logstash-values.yaml  --namespace elk

#Install Kibana with helm
helm install kibana elastic/kibana -f kibana-values.yaml  --namespace elk


# Deploy the Log-generating Demo Application
echo "Deploying demo application that generates logs..."
kubectl create namespace demo-app

cat log-generator-app.yaml
kubectl apply -f log-generator-app.yaml