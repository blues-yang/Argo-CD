secret=`kubectl get secret argocd-initial-admin-secret -n argocd -o yaml | grep password`
password_base64=${secret#*:}
password=`echo $password_base64 | base64 --decode`

echo -e "\e[44m Login Argo CD(https://localhost:443/) with admin/$password\e[49m"
error=`kubectl port-forward -n argocd svc/argocd-server 443:443 2>&1`
echo ❌ $error

while [[ $error == *"lost connection to pod"* ]] || [[ $error == *"pod not found"* ]]
do
   echo ✅ Reconnect service
   error=`kubectl port-forward -n argocd svc/argocd-server 443:443 2>&1`
   echo ❌ $error
done
