#!/bin/bash
echo ">>>>> Installing Rancher"
kubectl create namespace cattle-system

# Already done
# kubectl create namespace cert-manager

# Already done
# kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v1.13.2/cert-manager.crds.yaml

helm repo add rancher-latest https://releases.rancher.com/server-charts/latest

# Already done
# helm repo add jetstack https://charts.jetstack.io

helm repo update

# Already done
# helm install cert-manager jetstack/cert-manager --namespace cert-manager --version v1.13.2

kubectl get pods --namespace cert-manager

helm install rancher rancher-latest/rancher --namespace cattle-system --set hostname=rancher.local

kubectl -n cattle-system rollout status deploy/rancher

kubectl -n cattle-system get deploy rancher

echo "Rancher Password"
kubectl get secret --namespace cattle-system bootstrap-secret -o go-template='{{.data.bootstrapPassword|base64decode}}{{"\n"}}'

echo "<<<<< Rancher ready."
