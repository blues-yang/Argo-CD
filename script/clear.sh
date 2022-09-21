dockerd &
minikube start --force --driver=docker

kubectl delete namespace myapp
kubectl delete namespace argocd

minikube stop
pkill dockerd
