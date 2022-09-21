# Argo CD + MiniKube
Quick start Argo CD with local machine

## Install tool chain
run: `sudo ./install.sh`

## Start Argo CD
1. run: `sudo ./start.sh`, and save Argo CD user name/password
2. login Argo CD website: `https://localhost:8080/`, and manage your cluster

## Testing
1. login myApp website: `http://localhost:3200/`, and view the app
2. change & push [deployment.yaml](dev/deployment.yaml) into the repo
3. login Argo CD website: `https://localhost:8080/`, and review the change
4. login myApp website: `http://localhost:3200/`, and review the change

## Known issue
1. Could not find service of myapp/argocd
run `sudo clear.sh`
rerun `sudo start.sh`
