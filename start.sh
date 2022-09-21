dockerd &
minikube start --force --driver=docker

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl wait deployment -n argocd argocd-server --for condition=Available --timeout=90s
./script/connect-argo-cd-service.sh &

echo -e "\e[44m Login myapp(http://localhost:3200/)\e[49m"
error=`kubectl port-forward -n myapp svc/myapp-service 3200:3200 2>&1`
while [[ $error == *"Error from server (NotFound): namespaces"* ]]
do
   echo ❌ $error
   echo ⌛ Wait resource ready...
   kubectl replace -f application.yaml --force
   kubectl apply -f application.yaml
   sleep 10s
   error=`kubectl port-forward -n myapp svc/myapp-service 3200:3200 2>&1`
done

while [[ $error == *"lost connection to pod"* ]] || [[ $error == *"pod not found"* ]]
do
   echo ✅ Reconnect service
   error=`kubectl port-forward -n myapp svc/myapp-service 3200:3200 2>&1`
   echo ❌ $error
done

minikube stop
pkill dockerd
