Client Certificates for Clients
Admin: admin.crt admin.key
Kube-api server: apiserver-kubelet-client.crt, apiserver-kubelet-client.key
Kube-api server: apiserver-etcd-client.crt, apiserver-etcd-client.key
Kube-scheduler:
kube-controller-manager:
kube-proxy:
kubelet:

Server Certificates for Servers:
ETCD: etcdserver.crt, etcdserver.key
KUBE-API: apiserver.crt, apiserver.key
KUBELET: kubelet.crt, kubelet.key

VIEW CERT DETAILS

HARD WAY:
cat /etc/systemd/system/kube-apiserver.service
KUBEADM:
cat /etc/kubernetes/manifest/kube-apiserver.yml

openssl x509 -in /etc/kubernetes/pki/apiserver.crt -text 


CERT API:
apiVersion: certificates.k8s.io/v1kind: CertificateSigningRequestmetadata:  name: akshayspec:  groups:  - system:authenticated  request: $FROMTHEFILE  signerName: kubernetes.io/kube-apiserver-client  usages:  - client auth
kubectl get csr
kubectl certificate approve name
kubectl certificate deny name


KUBECONFIG:
The file is in ~/.kube/config Importants files:

Clusters: Example: dev, prod, aws
Context: Relation between the cluster and the user. Example admin@production
Users: admin, developer, prod

Note: We can specify the current-context

kubectl config --kubeconfig=config-demo set-context dev-frontend