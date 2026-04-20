#!/bin/bash

set -e

echo "🔧 Creating Docker network..."
docker network create roboshop || true

echo "🗄️ Building and starting MongoDB..."
cd mongodb
docker build -t mongodb:v1 .
docker run -d --name mongodb --network roboshop  mongodb:v1 || true
cd ..

echo "🗄️ Building and starting MySQL..."
cd mysql
docker build -t mysql:v1 .
docker run -d --name mysql --network roboshop -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root mysql:v1 || true
cd ..

echo "🗄️ Starting Redis..."
docker run -d --name redis --network roboshop redis:7 || true

echo "🗄️ Starting RabbitMQ..."
docker run -d --name rabbitmq --network roboshop -e RABBITMQ_DEFAULT_USER=roboshop -e RABBITMQ_DEFAULT_PASS=roboshop123 rabbitmq:3 || true


echo "📦 Building and starting Catalogue..."
cd catalogue
docker build -t catalogue:v1 .
docker run -d --name catalogue --network roboshop catalogue:v1 || true
cd ..

echo "📦 Building and starting User..."
cd user
docker build -t user:v1 .
docker run -d --name user --network roboshop user:v1 || true
cd ..

echo "📦 Building and starting Cart..."
cd cart
docker build -t cart:v1 .
docker run -d --name cart --network roboshop  cart:v1 || true
cd ..

echo "📦 Building and starting Shipping..."
cd shipping
docker build -t shipping:v1 .
docker run -d --name shipping --network roboshop  shipping:v1 || true
cd ..

echo "📦 Building and starting Payment..."
cd payment
docker build -t payment:v1 .
docker run -d --name payment --network roboshop payment:v1 || true
cd ..

echo "🌐 Building and starting Frontend..."
cd frontend
docker build -t frontend:v1 .
docker run -d --name frontend --network roboshop -p 80:80 frontend:v1 || true
cd ..

echo "✅ All services are up!"