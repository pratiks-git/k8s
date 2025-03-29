## ELK DEMO

This repository contains the scripts to create an EKS cluster and launch a demo app and observability stack ELK(Elasticksearch, Logstash, Kibana). 

### Short Description:
- Demo app: Generates dummy logs
- Filebeat: Forwards log from containerized applications and forwards to logstash
- Logstash: Logstash processes and transforms logs
- Elasticsearch: Core component for storing and indexing logs
- Kibana: Kibana provides UI for visualizing data and interacting with Elasticsearch


#### Steps
- Run the k8s-cluster.sh script
    - This script will 
        - Check the prerequisites
        - Create EKS cluster
        - Launch ELK stack with helm
        - Launch demo-app for generating logs

- To access the Kibana dashboard 
    - Get the port on which Kibana is running with
    ```
    kubectl get svc kibana-kibana -n elk -o jsonpath="{.spec.ports[0].port}"
    ```
    - Runt the below command from seperate shell to access the kibana dashboard from localhost:<port>
    ```
    kubectl port-forward svc/kibana-kibana -n elk <port>:<port>
    ```
    - To get username and password for the kibana use below commands
    ```
    kubectl get secret -n elk elasticsearch-master-credentials -o jsonpath="{.data.username}" | base64 --decode

    kubectl get secret -n elk elasticsearch-master-credentials -o jsonpath="{.data.password}" | base64 --decode
    ```
