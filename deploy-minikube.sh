#!/bin/bash

set -e

NAMESPACE="vrms"

echo "🚀 Starting VRMS Minikube Deployment"
echo "==================================="

# Start Minikube if not running
if ! minikube status | grep -q "Running"; then
    echo "🔵 Starting Minikube..."
    minikube start --cpus=4 --memory=7837
fi

echo "🔧 Enabling required addons..."
minikube addons enable ingress

echo "🐳 Switching Docker to Minikube..."
eval $(minikube docker-env)

# Build microservice images
echo "📦 Building backend microservice images..."

cd User-Service
docker build -t vrms-user-service:latest .
cd ..

cd NGO-Postings-Service
docker build -t vrms-ngo-posting-service:latest .
cd ..

cd Matching-Service/matching
docker build -t vrms-matching-service:latest .
cd ../..

cd Analytics-Service
docker build -t vrms-analytics-service:latest .
cd ..

cd VRMS_Frontend/vrms-frontend
docker build -t vrms-frontend:latest .
cd ../..

echo "📁 Applying Kubernetes YAMLs..."
kubectl apply -f vrms-k8s.yaml

echo "⏳ Waiting for pods to initialize..."
sleep 40

MINIKUBE_IP=$(minikube ip)

echo ""
echo "🎉 Deployment Complete! Access your services:"
echo "-------------------------------------------"
echo "Frontend:           http://$MINIKUBE_IP:5174"
echo "User API:           http://$MINIKUBE_IP:8080"
echo "NGO API:            http://$MINIKUBE_IP:8082"
echo "Matching API:       http://$MINIKUBE_IP:8081"
echo "Analytics:          http://$MINIKUBE_IP:8000"
echo "Loki Logs:          http://$MINIKUBE_IP:3100"

echo ""
echo "Check status: kubectl get pods -n vrms"
echo "View logs:   kubectl logs -n vrms <pod>"

