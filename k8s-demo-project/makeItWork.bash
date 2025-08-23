# Order may not matter in your life
# But it does matter in K8s

# Let's create the mongo deployment
kubectl apply -f credentials/mongo-secret.yaml
kubectl apply -f pvc/mongodb-pvc.yaml
kubectl apply -f deployments/mongo-deployment.yaml
# Then create the mongo service
kubectl apply -f services/mongo-service.yaml

# Now let's create the mongo-express deployment
kubectl apply -f credentials/mongo-configmap.yaml
kubectl apply -f deployments/mongo-express-deployment.yaml
# Then create the mongo-express service
kubectl apply -f services/mongo-express-service.yaml

# Bringing in Ingress
kubectl apply -f ingress.yaml


# --- HOW TO ACCESS THE APPLICATION ---
# Choose either Method 1 or Method 2

# Method 1: (using Port Forward)
# 1. Find the Ingress controller pod name:
#    kubectl get pods -n ingress-nginx
# 2. Open a NEW terminal and run (replace <pod-name>):
#    kubectl port-forward --namespace ingress-nginx pod/<pod-name> 8080:80
# 3. Use the browser to go to http://check-kar.com:8080
#    (Requires hosts file edit: 127.0.0.1 check-kar.com)
# 4. If you can't edit your files because you have some secured laptop from company
#    Run the below command in another terminal, it will spit the html of the page which shows things are working fine
#    curl --header "Host: check-kar.com" http://127.0.0.1:8080

# Method 2: (using Tunneling)
# 1. Open a NEW terminal and run (leave it open):
#    minikube tunnel
# 2. Use the browser to go to http://check-kar.com
#    (Requires hosts file edit: 127.0.0.1 check-kar.com)

# For both methods, log in to the UI with:
# Username: admin
# Password: pass


# TO TEST DATA PERSISTENCE :

# 1. Find your MongoDB pod name:
#    kubectl get pods

# 2. Add data to the database using 'kubectl exec'.
#    Replace <mongodb-pod-name> with your actual pod name.
#
#    kubectl exec <mongodb-pod-name> -- mongosh --username Saqib --password okok --eval 'db.getSiblingDB("testdb").users.insertOne({ name: "Saqib", status: "testing from cli" });'

# 3. Verify the data was added:
#
#    kubectl exec <mongodb-pod-name> -- mongosh --username Saqib --password okok --eval 'db.getSiblingDB("testdb").users.find();'

# 4. Simulate a pod restart to test persistence:
#
#    kubectl delete pod <mongodb-pod-name>

# 5. Wait for the new pod to be in the 'Running' state, then find its new name:
#    kubectl get pods

# 6. Check if the data is still there.
#    Replace <new-mongodb-pod-name> with the new pod's name.
#    You should see your data, which proves the PVC is working.
#
#    kubectl exec <new-mongodb-pod-name> -- mongosh --username Saqib --password okok --eval 'db.getSiblingDB("testdb").users.find();'