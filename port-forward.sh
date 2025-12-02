#!/bin/bash

NAMESPACE="vrms"

echo "🔄 Starting port forwarding for VRMS services..."

# User Service
kubectl port-forward svc/user-service 8080:8080 -n $NAMESPACE >/dev/null 2>&1 &
echo "✔ User Service → http://localhost:8080"

# NGO Posting Service
kubectl port-forward svc/ngo-posting-service 8082:8082 -n $NAMESPACE >/dev/null 2>&1 &
echo "✔ NGO Service  → http://localhost:8082"

# Matching Service
kubectl port-forward svc/matching-service 8081:8081 -n $NAMESPACE >/dev/null 2>&1 &
echo "✔ Matching     → http://localhost:8081"

# Analytics Service
kubectl port-forward svc/analytics-service 8000:8000 -n $NAMESPACE >/dev/null 2>&1 &
echo "✔ Analytics    → http://localhost:8000"

# Frontend
kubectl port-forward svc/frontend 5174:5174 -n $NAMESPACE >/dev/null 2>&1 &
echo "✔ Frontend     → http://localhost:5174"

echo ""
echo "🎉 All services forwarded!"
echo "Press CTRL+C to stop forwarding."

