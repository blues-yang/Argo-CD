dockerd &
minikube start --force --driver=docker

kubectl replace -f application.yaml --force
kubectl delete namespace myapp
kubectl delete namespace argocd
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

minikube stop
pkill dockerd
