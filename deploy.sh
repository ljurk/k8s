k3d cluster create mycluster -p "80:80@loadbalancer" -p "443:443@loadbalancer" #--servers 3 --agents 3
kubectl apply -f helloworld.yml
kubectl create namespace argocd
kubectl apply -n argocd -f argocd.yml
argoPass=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
echo $argoPass
kubectl port-forward svc/argocd-server -n argocd 8080:443
#kubectl apply -f k8s-dashboard.yml


# dashboard
#helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
#helm install dashboard kubernetes-dashboard/kubernetes-dashboard \
#--set protocolHttp=true \
#--set ingress.annotations."kubernetes\.io/ingress\.class"=traefik \
#--set ingress.enabled=true \
#--set ingress.hosts[0]=dashboard.k3d
