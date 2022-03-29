
#Metric server: The most basic built-in monitoring solution
kubectl top node
kubectl top pods

#LOGS
kubectl logs -f POD_NAME CONTAINER_NAME

#CONTAINER_NAME is only necessary if we have more than one container in a pod