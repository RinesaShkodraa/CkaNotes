
#MANUAL SCHEDULING----
#assign nodeName in yaml config only at creation time
spec:
    nodeName: node02
#you cant modify a nodeName, you should create a BINDING object

#Labels and selectors----
#if you have two pods with different functionalities, 
#mention both labels in selector

#ANNOTATIONS----
#additional details to be more specific after labels
#like git commits

#filtrate using more than one selector on all namespaces
k get all -l env=prod,bu=finance,tier=frontend

k get pods --selector env=dev

!= # this command would give us all resources without the env key label



#TAINT--> nodes AND TOLERATIONS----> pods --- for scheduler--------
#taints and tolerations are used on scheduler to set restrictions,
# on what pods can be scheduled on a node

# 1) set taint, no pods are tolerant to taint
# 2) specify which pods are tolerant -add toleration to certain Pod

kubectl taint nodes node-name key=value: taint-effect
 
#taint effects:
# 1) NoSchedule-> will only allow scheduling pods that have tolerations
# 2) PreferNoSchedule -> will try to avoid scheduling pods that don’t have tolerations 
# 3) NoExecute-> new pods will not be scheduled, expel pods that are intolerant

kubectl taint nodes nginx-pod app= blue:NoExecute

#Tolerations- PODS KEY VALUE EFFECT 
spec:
    tolerations:
    - key: "app"
      value:"blue"
      effect:"NoExecute"
#ENCODED IN "" !!!

#UNTAINT
kubectl taint nodes controlplane node-role.kubernetes.io/master:NoSchedule-
#DONT FORGET THE -




#NODE SELECTORS------

nodeSelector:
    size: Large #key value pair labels in the nodes


#label nodes:
kubectl label nodes node-name key=value


#NODE AFFINITY----- key, operator, value
#advanced capabilities, config in pod
#Node affinity is a set of rules used by the scheduler 
#to determine where a pod can be placed.

template:
spec:
    affinity:
     nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
       nodeSelectorTerms:
       - matchExpressions:
        - key: size
          operator: In or Not In
          value:
          - Large
          - Medium

requiredDuringSchedulingIgnoredDuringExecution
preferedDuringSchedulingIgnoredDuringExecution

Note: Remember the operator Exists is without values

#taints and tolerance vs node affinity
#use taints on nodes, node affinity in pods


#RESOURCE REQUIREMENTS AND LIMITS
#the containers are assigned a default CPU request of .5 and memory of 256Mi
apiVersion: v1
kind: LimitRange
metadata:
  name: mem-limit-range
spec:
  limits:
  - default:
      memory: 512Mi
    defaultRequest:
      memory: 256Mi
    type: Container

#OOMkilled
#pod was terminated because they used more memory than allowed

kubectl get pods elephant -o yaml > elephant.yaml

#DAEMONSET
#makes sure one copy of the pod is always present in all nodes
# monitoring solution, logs viewer
#kube proxy can be deployed as a daemon set

#created by kube api server
#deploy monitoring agents, logging
#ignored by kube scheduler

Note: 
kubectl create deployment elasticsearch --image=random -n kube-system --dry-run=client -o yaml > fluentd.yaml.
remove the replicas and strategy fields 
Also, change the kind from Deployment to DaemonSet


#STATIC PODS
#pods that are created by kubelet without the need of api server or etcd
#you can configure kubelet to get pod details from a directory
#it will constantly check for new definition files, and once 1 is deleted, so is the pod.
#pod-manifest-path
docker ps

#created by kubelet
#deploy control plane components as static pods
#ignored by scheduler

# 2 ways: path-to- or kubeconfig.yaml
example:
kubectl run --restart=Never --image=busybox static-busybox --dry-run=client -o yaml --command -- sleep 1000 > /etc/kubernetes/manifests/static-busybox.yaml


#MULTIPLE SCHEDULERS
#we can create custom scheduler
#leader elect option

#to have multiple schedulers running, you either set leader elect to false
#or additional parameter to set a lock object name- differentiate the new custom
#scheduler from the default during leader election process

#create new pod for custom schedule
spec:
    scheduleName: my-custom-sch

kubectl get events
kubectl get logs -name0of-sch --n kube-system

- --leader-elect=false
- --port=10282
- --scheduler-name=my-scheduler
- --secure-port=0






