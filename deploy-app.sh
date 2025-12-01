#!/bin/bash

# Simple VRMS Minikube Deployment Script
set -e

echo "🚀 VRMS Simple Deployment"
echo "=========================="
echo ""

# Check Minikube
if ! minikube status | grep -q "Running"; then
    echo "Starting Minikube..."
    minikube start --cpus=4 --memory=7837
    minikube addons enable ingress
fi

echo "✅ Minikube running"
MINIKUBE_IP=$(minikube ip)
echo "📍 IP: $MINIKUBE_IP"
echo ""

# Build images
echo "🔨 Building Docker images..."
eval $(minikube docker-env)

echo "  Building User Service..."
cd User-Service && mvn clean package -DskipTests -q && docker build -t vrms-user-service:latest -q . && cd .. && echo "  ✅ Done"

echo "  Building NGO Service..."
cd NGO-Postings-Service && mvn clean package -DskipTests -q && docker build -t vrms-ngo-service:latest -q . && cd .. && echo "  ✅ Done"

echo "  Building Matching Service..."
cd Matching-Service/matching && mvn clean package -DskipTests -q && docker build -t vrms-matching-service:latest -q . && cd ../.. && echo "  ✅ Done"

echo "  Building Analytics Service..."
cd Analytics-Service && docker build -t vrms-analytics-service:latest -q . && cd .. && echo "  ✅ Done"

echo "  Building Frontend..."
cd VRMS_Frontend/vrms-frontend && docker build -t vrms-frontend:latest -q . && cd ../.. && echo "  ✅ Done"

echo ""

# Update YAML with correct IP
sed -i.bak "s/192\.168\.49\.2/$MINIKUBE_IP/g" vrms-minikube.yaml

# Deploy
echo "📦 Deploying to Minikube..."
kubectl apply -f vrms-minikube.yaml

echo ""
echo "⏳ Waiting for services to start (2 minutes)..."
sleep 120

echo ""
echo "✅ Deployment Complete!"
echo "=========================="
echo ""
echo "🌐 Access URLs:"
echo "  Frontend:     http://$MINIKUBE_IP:30174"
echo "  User API:     http://$MINIKUBE_IP:30080"
echo "  NGO API:      http://$MINIKUBE_IP:30082"
echo "  Matching API: http://$MINIKUBE_IP:30081"
echo "  Analytics:    http://$MINIKUBE_IP:30000"
echo ""
echo "📊 Check status: kubectl get pods -n vrms"
echo "📋 View logs: kubectl logs -f deployment/user-service -n vrms"
