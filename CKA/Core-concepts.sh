#Cluster Architecture

#Master Node---
#API server- orchestrates operations within cluster, exposes k8s api
#Scheduler
#Control Manager - Node Controller, Replication Controller
#etcd

#Worker Node---
#container runtime- ex. docker
#kubelet - interacts with container and node, runs on each node (listens to api server, takes instructions)
#kubeproxy- allows the worker node containers to reach each other

#ETCD---
#key/value format store
#port 2379- default
#Specify API VERSION, PATH TO TLS
export ETCDCTL_API=3

#API SERVER---
#authenticate user> validate request> retrieve data> update etcd> scheduler> kubelet

#CONTROLLER MANAGER---
#lifecycle management
#watch status 
#monitor timing: 5secs, 40secs to mark it unreachable, 5mins to come back up

#SCHEDULER ---
#decides which nodes are available for certain resource requirements
#filter nodes> rank nodes 

#kubeproxy---
#looks for services, creates rules(IP table rules) to forward traffic to services


#yaml---
#apiVersion: -POD- v1, -Service, v1, -ReplicaSet apps/v1, -Deployment apps/v1
--------------------
apiVersion: v1
kind: Pod
metadata: #dictionary7
    name: front
    labels:
        key: value
spec: #dictionary
    containers: #list/array
    - name: #1st
         image:
    - name: #2nd 
         image:
--------------------
kubectl apply -f name.yaml
kubectl describe pod name
kubectl get pods -o wide

#REPLICASETS- controller----
#multiple instances of a single pod-   high availability, share load.
#can run across multiple nodes
----------------
spec:
 template:
 replicas:
 selector:
----------------

#example:
apiVersion:app/v1
kiind: ReplicaSet
metadata:
    name: replica
    labels:
        type: front
spec: 
    template: #pod config template----- required to create pod if one dies
        metadata: #dictionary
            name: front
            labels:
                key: value
        spec: #dictionary
            containers: #list/array
            - name: #1st
                image:nginx
            - name: #2nd 
                 image:jenkins
replicas: 3 #set desired number
selector: #selector
    matchLabels:
        type: front #has to match the pod labels

kubectl create -f replicaFile.yaml
kubectl get replicaset

#LABELS AND SELECTORS--- identifies pods to manage by replicaset
# create labels when creating pods
# add the labels to> selector: matchLabels: (pod label)

#SCALE RS
update the file and run:
-kubectl replace -f 
or:
-kubectl scale --replicas=6 -f file-name.yaml --- file
- k scale rs -rs name- --replicas=x ---rs




#DEPLOYMENTS-----
# same config file as rs


#RUN COMMAND------
#create NGINX pod:
kubectl run nginx --image=nginx

 #create deployment
kubectl create deployment --image=nginx nginx

 #Generate Deployment YAML file (-o yaml). Don't create it(--dry-run)
 kubectl create deployment --image-nginx nginx --dry-run=client -o yaml > nginx-deployment.yaml

 #save it to a file
 kubectl create -f nginx-deployment.yaml

 #specify replicas in dry run
 kubectl create deployment --image=nginx nginx --replicas= 6 --dry-run=client -0 yaml > nginx-depl.yaml



 #NAMESPACES------
# 1) default 2) kube-system 3)kube-public
# policies, resource limits
# pods in different ns can communicate

service-name.namespace.svc.cluster.local
#specify under metadata in yaml

kubectl create namespace dev
kubectl get pods --all-namespaces

#change ns permanently:
kubectl config set-context $(kubectl config current-context) --namespace=dev

| grep -i ____




#SERVICES---------
#Node port- 30000-32767 range. Exposes service on a static port on node's ip address
#Cluster Ip- service creates a virtual ip inside the cluster to enable connection
#Load Balancer- creates lb to distribute traffic.


#NODE PORT--------
apiVersion:v1
kind: Service
metadata: 
    name: my-service
spec:
    type: NodePort
    ports: #array 
    - targetPort: 80 #podPort 
      port: 80 #its own port
      nodePort: 30000-32767 #can be automatically allocated
    selector: 
        matchLabels:
            app: front #necessary to define pod


#NODEPORT
#accessible from outside the cluster

#CLUSTER IP- default type
#only accessible from within cluster


#LOADBALANCER
#cloud specific
#accessible from outside the cluster
#has dns name
#ssl termination, health checks, access logs 


#IMPERATIVE AND DECLARATIVE APPROACHES

#Imperative:
k run --image=nginx nginx
k create deployment --image=nginx nginx
k expose deployment nginx --port 8080 
k expose pod redis --port=6379 --name redis-service #creates service for pod in clusterip kind
k set image deployment nginx nginx=nginx:1.12

#Declarative
k apply -f .yaml
k apply -f /path/to/config-file

#APPLY command: local file, live configuration


