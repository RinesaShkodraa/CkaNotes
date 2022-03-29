#ETCD
#Consistent and highly-available key value store for all cluster data
./etcdctl set key1 value1
./etcdctl get key1


#API SERVER
#the only component that interacts with ETCD directly
#component of control plane that exposes k8s api. scales horizontally 
#authenticate, validate, retrieve data, update ETCD, scheduler, kubelet


#CONTROLLER MANAGER
#continuously monitors the state of components 
#each is a separate process,all are compiled into a single binary and run in a single process


#KUBE SCHEDULER
#watches for newly created Pods with no assigned node and selects a node for them to run on
#only responsible for deciding, Kubelet creates the pod on the nodes

#KUBELET
#makes sure pods are running and healthy, Kubeadm doesnt deploy kubelet

#KUBE PROXY
#runs on each node to provice and maintain networking rules [ip tables]for inside and outside the cluster
#deployed as a daemon set

#SERVICES---------
#Node port- 30000-32767 range. Exposes service on a static port on node's ip address
#Cluster Ip- service creates a virtual ip inside the cluster to enable connection
#Load Balancer- creates lb to distribute traffic.