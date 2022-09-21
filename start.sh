dockerd &
minikube start --force --driver=docker

./script/connect-argo-cd-service.sh &

kubectl apply -f application.yaml

echo -e "\e[44m Login myapp(http://localhost:3200/)\e[49m"
error=`kubectl port-forward -n myapp svc/myapp-service 3200:3200 2>&1`
echo ❌ $error

while [[ $error == *"lost connection to pod"* ]] || [[ $error == *"pod not found"* ]]
do
   echo ✅ Reconnect service
   error=`kubectl port-forward -n myapp svc/myapp-service 3200:3200 2>&1`
   echo ❌ $error
done

minikube stop
pkill dockerd
