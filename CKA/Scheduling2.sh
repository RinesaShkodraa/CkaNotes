
#MANUAL SCHEDULING
In a pod definition we can configure a nodeName (for default isnt set)

spec:
	nodeName: node02



#LABELS AND SELECTORS
kubectl get pods --selector app=App1



#TAINTS AND TOLERATIONS
Taints allow a node to repel a set of pods.

Tolerations are applied to pods, and allow (but do not require) 
the pods to schedule onto nodes with matching taints.

Note: Taints are set on nodes, and tolerations are set on pods

Taint Effects:
NoSchedule
PreferNoSchedule
NoExecute

kubectl taint nodes node-name key=value:taint-effect

tolerations:
	- key: "app"
	  operator: "Equal"
	  value: "blue"
	  effect: "NoSchedule"



#NODE AFFINITY
spec:
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: kubernetes.io/e2e-az-name
            operator: In
            values:
            - e2e-az1
            - e2e-az2

Note: Remember the operator Exists is without values



#REQUESTS AND LIMITS
resources:
	    requests:
	      memory: "1Gi"
	      cpu: 1

spec:
  limits:
  - default:
      memory: 512Mi
    defaultRequest:
      memory: 256Mi
    type: Container



#DAEMONSETS
A DaemonSet ensures that all (or some) Nodes run a copy of a Pod
 Deleting a DaemonSet will clean up the Pods it created

 create deployment elasticsearch --image=imgnm -n kube-system --dry-run=client -o yaml > fluentd.yaml
then modify the yaml to daemonset
(KUBEPROXY)




#STATIC PODS
We can deploy a POD on a node using Kubelet without any control-plane

kubectl run --restart=Never --image=busybox static-busybox --dry-run=client -o yaml --command -- sleep 1000 > /etc/kubernetes/manifests/static-busybox.yaml




#MULTIPLE SCHEDULERS
The –leader-elect=true is when we have many schedulers with multiple master node. 
Only one scheduler can be the master.

spec:
  schedulerName: my-scheduler #SPECIFY SCHEDULER IN POD

