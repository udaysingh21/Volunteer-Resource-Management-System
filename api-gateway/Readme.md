# API Gateway - VRMS

This gateway centralizes all backend microservice routes behind a single entry point.

## Features
- Central routing for all microservices
- Simpler frontend integration
- Service abstraction and security layer foundation
- Plug-and-play with existing microservices

## Routes
- /users → User Service
- /postings → NGO Postings Service
- /match → Matching Service
- /analytics → Analytics Service

## Run
docker-compose up --build
Then access: http://localhost:8085
