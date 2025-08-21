# Order may not matter in your life
# But it does matter in K8s

# Let's create the mongo deployment
kubectl apply -f credentials/mongo-secret.yaml
kubectl apply -f deployments/mongo-deployment.yaml
# Then create the mongo service
kubectl apply -f services/mongo-service.yaml

# Now let's create the mongo-express deployment
kubectl apply -f credentials/mongo-configmap.yaml
kubectl apply -f deployments/mongo-express-deployment.yaml
# Then create the mongo-express service
kubectl apply -f services/mongo-express-service.yaml

# to set the external IP for our service in minikube
minikube service mongo-express-service

# Basic Credentials in UI=> username = admin and Password = pass