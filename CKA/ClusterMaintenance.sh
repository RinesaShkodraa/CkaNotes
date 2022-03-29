
#OS UPGRADES
 
 #move pods to other nodes, and mark node as unschedulable
 kubectl drain node01

 #make it schedulable
 kubectl uncordon node01

 #make it unschedulable
 kubectl cordon node01

#Running the uncordon command on a node will not automatically
#schedule pods on the node
#When new pods are created, they will be placed on node01.

#A forceful drain of the node will delete any pod that is not part of a replicaset

#VERSIONS
V1.11.3
MAJOR, MINOR, PATCH

#strategy for upgrade:

# first is master node, 
# 1 all worker nodes down and upgrade
# 2 drain
#3 make new worker nodes 

kubeadm - upgrade

kubeadm upgrade plan

apt-get upgrade -y kubeadm=1.11
kubeadm upgrade appy v1.11

----------
apt update
apt install kubeadm=1.20.0-00
kubeadm upgrade apply v1.20.0
kubeadm upgrade node
apt install kubelet=1.20.0-00
systemctl restart kubelet



#BACKUP AND RESTORE METHODS

#ETCD
etcdctl snapshot save name.db
etcdctl snapshot status name.db


#restore
service kube-apiserver stop 
etcdctl snapshot restore name.db \
--data-dir /dir/ 
#
systemctl daemon-reload
service etcd restart
service kube-apiserver start


--endpoints=https://[127.0.0.1]:2379 \
--cacert=/etc/kubernetes/pki/etcd/ca.crt \
--cert=/etc/kubernetes/pki/etcd/server.crt \
--key=/etc/kubernetes/pki/etcd/server.key \

ETCDCTL_API=3 etcdctl — endpoints=[ENDPOINT] — cacert=[CA CERT]
 — cert=[ETCD SERVER CERT]
 — key=[ETCD SERVER KEY] snapshot save [BACKUP FILE NAME]



Execute “member list” and “snapshot status” to check hash
stop service - systemctl stop etcd
restore another backup using same certs, endpoint, and DIFFERENT dir
chown -R etcd:etcd /DIR_YOU_RESTORE
change dir in the service file
system daemon-reload
systermctl start etcd
systemctl status etcd
member list - to check you have different hash

ETCDCTL_API=3 etcdctl  --data-dir /var/lib/etcd-from-backup \
snapshot restore /opt/snapshot-pre-boot.db


Read	4
Write	2
Execute	1

chmod 644 file1