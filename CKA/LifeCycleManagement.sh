
# UPDATES AND ROLLBACKS

#types of strategies:
# recreate, rollout

#When a new rollout is triggered a new deployment REVISION is created
# This helps us keep track of the changes made to our deployment and
# enables us to roll back to a previous version of deployment 

kubectl rollout status deployment/myapp-deployment

kubectl rollout history deployment/myapp-deployment

kubectl rollout undo deployment/myapp-deployment

#A Deployment’s rollout is triggered if and only if the Deployment’s Pod template 
#(that is, .spec.template) is changed, 
 #Other updates, such as scaling the Deployment, do not trigger a rollout.

kubectl edit deployment
alias search=grep



#COMMANDS AND ARGUMENTS
spec:
 containers:
  command: ["sleep"] # overrides ENTRYPOINT
  args: ["10"]# overrides CMD

  command:
      - "sleep"
      - "2000"
  args: ["sleep","10"]


#when to use commands or both



#ENVIRONMENT VARIABLES
#PLAIN KEY:
env: #array
 -name: APP_CLR
  value: pink

#CONFIG MAP or Secret:

env:
 -name:
  valueFrom:
   configMapKeyRef:
   #or
   configSecretRef:


#CONFIG MAPS:

imperative:
kubectl create configmap app-config --from-literal=APP_COLOR=blue

declarative:
kubectl create -f configmap.yml

kubectl get configmaps
kubectl describe configmap


#SECRETS

echo -n 'rinesa' | base64

dev-user.crt
#Yaml- declarative
apiVersion: v1
kind: Secret
metadata:
	name: app-secret
data:
	DB_Host: bxlzcWw=
	DB_User: cm9vdA==
	DB_Password: cFGzd3Jk	


#imperative
kubectl create secret generic <secret-object-name> <flags>

kubectl create secret generic db-secret --from-literal=DB_Host=sql01
 --from-literal=DB_User=root --from-literal=DB_Password=password123

:1,$d ----- DELETE ALL LINES IN VIM

 #MULTI CONTAINER PODS
 Note: Multi-Container Pods share Lifecycle, Network and Storage

 # 3 Patterns
 # SIDE CAR
 
#INIT CONTAINERS
Pod can also have one or more init containers, 
which are run before the app containers are started

If a Pods init container fails, the kubelet repeatedly restarts
 that init container until it succeeds. 
 if the Pod has a restartPolicy of Never
Kubernetes treats the overall Pod as failed
