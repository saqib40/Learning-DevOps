# bundle the chart
# get one level up this directory
# then run
helm package k8s-demo-project-helm

# in production namespace
helm install another-release ./my-mongo-app-0.1.0.tgz -n production --create-namespace -f k8s-demo-project-helm/production-values.yaml