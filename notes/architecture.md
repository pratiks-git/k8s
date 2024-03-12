By default K8s is a cluster. It has master and worker nodes

On high level k8s architecture can be divided into tow main components 
	1. Control plane - master node
	2. Data plane - worker nodes
	
## Worker node

A worker node has 3 components
1. kubelet - An agent which communicates with master node and ensures the pod is up and running
2. kube-proxy - A networking componeny (uses IP tables)
3. container runtime - Runs container
## Master node 

Master node has 5 main components
1. API server - Core of K8s,communicates with worker nodes, exposes the service to outside traffic and takes requests
2. Scheduler - Scheduling resources 
3. etcd - Stores all the cluster data as key, value pairs. Acts like a database
4. Controller manager - Takes care of controller like ReplicaSets, Deployments, etc..
5. CCM(Cloud Controller Manager) - When using K8s on cloud, cloud specific 
