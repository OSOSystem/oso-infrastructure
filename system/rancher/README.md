# OSO Rancher

## Required Hardware
3 Nodes

Docker setup on the Nodes -> https://github.com/rancher/install-docker
```
wget -O - https://raw.githubusercontent.com/rancher/install-docker/master/19.03.2.sh | sh
```
Or automatic with a script like setup_nodes.sh 

## Required Tools
```
kubectl - Kubernetes command-line tool.
rke - Rancher Kubernetes Engine, cli for building Kubernetes clusters.
helm - Package management for Kubernetes.
```

# Setup

## NGINX Load Balancer
We are Load Balancing with Cloudflare. 

## RKE

if you are using a password for your private key: ssh-add ~/.ssh/id_rsa
```
rke up --config ./rancher-cluster.yml
```
Save the kube_config-cluster.yml content to your .kube/config

Check with kubectl if everything is right

## Install helm
```
kubectl -n kube-system create serviceaccount tiller

kubectl create clusterrolebinding tiller \
  --clusterrole=cluster-admin \
  --serviceaccount=kube-system:tiller

helm init --service-account tiller
```

## Install Rancher
```
helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
```

## Certificates
```
kubectl apply -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.9/deploy/manifests/00-crds.yaml

kubectl create namespace cert-manager

kubectl label namespace cert-manager certmanager.k8s.io/disable-validation=true

helm repo add jetstack https://charts.jetstack.io

helm repo update

helm install \
  --name cert-manager \
  --namespace cert-manager \
  --version v0.9.1 \
  jetstack/cert-manager

helm install rancher-stable/rancher \
  --name rancher \
  --namespace cattle-system \
  --set hostname=rancher.ososystem.de \
  --set ingress.tls.source=letsEncrypt \
  --set letsEncrypt.email=kontakt@pierrewilken.de
```

Wait till Rancher is rolled out!
```
kubectl -n cattle-system rollout status deploy/rancher
```

## That's it, have fun :)

# Don`t make the kube_config.yml and/or the .rkestate public!