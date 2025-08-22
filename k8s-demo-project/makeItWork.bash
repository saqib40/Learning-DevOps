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
# minikube service mongo-express-service (if we make the mongo-express service as LoadBalancer aka external service)
# Basic Credentials in UI=> username = admin and Password = pass

## Bringing in Ingress
kubectl apply -f ingress.yaml

## Accessing the application : (I am using WSL)

# Method 1: (using Port Forward, will work surely even if you have )

# 1. Find the Ingress controller pod name.
#    Run: 
kubectl get pods -n ingress-nginx
#    (Copy the name of the pod starting with 'ingress-nginx-controller-...')

# 2. Open a NEW, separate terminal and start the port-forward.
#    You must leave this terminal open.
Replace <pod-name> with the name from Step 1.
kubectl port-forward --namespace ingress-nginx pod/<pod-name> 8080:80

# 3. Test with curl from another terminal to print the HTML:
curl --header "Host: check-kar.com" http://127.0.0.1:8080

# 4. To use a browser, make sure your Windows hosts file has this line: (company firewall may not allow this)
#    127.0.0.1       check-kar.com

# 5. Open your browser and go to:
#    http://check-kar.com:8080

# 6. Log in to the UI with these credentials:
#    Username: admin
#    Password: pass

# Method 2: (using tunneling, if you have company firewall it might be blocked)

# 1. Open a NEW, separate terminal and run this command.
#    You must leave this terminal open.
#
#    minikube tunnel

# 2. Make sure your Windows hosts file has this line:
#    127.0.0.1       check-kar.com

# 3. Open your browser and go to:
#    http://check-kar.com

# 4. Log in to the UI with these credentials:
#    Username: admin
#    Password: pass