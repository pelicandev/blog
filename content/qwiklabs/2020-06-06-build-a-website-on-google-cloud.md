---
title: 'Build a Website on Google Cloud: Challenge Lab - Qwiklabs Answers'
date: 2020-06-06T14:00:00+02:00
tags: ["qwiklabs","qwiklabs-answers", "gcp"]
aliases: 
    - "/2020/06/06/build-a-website-on-google-cloud/"
    - "/qwiklabs/2020-06-06-build-a-website-on-google-cloud/"
---

# [Build a Website on Google Cloud: Challenge Lab](https://google.qwiklabs.com/focuses/11765?parent=catalog)

#### Task 1: Download the monolith code and build your container
```bash
git clone https://github.com/googlecodelabs/monolith-to-microservices.git
cd monolith-to-microservices/
sh setup.sh
gcloud builds submit --tag gcr.io/${GOOGLE_CLOUD_PROJECT}/fancytest:1.0.0 ~/monolith-to-microservices/monolith
```

#### Task 2: Create a kubernetes cluster and deploy the application
```bash
gcloud container clusters create fancy-cluster --num-nodes 3 --region us-central1-a
kubectl create deployment fancytest --image=gcr.io/${GOOGLE_CLOUD_PROJECT}/fancytest:1.0.0
kubectl expose deployment fancytest --type=LoadBalancer --port 80 --target-port 8080
```

#### Task 3: Create a containerized version of your Microservices
```bash
gcloud builds submit --tag gcr.io/${GOOGLE_CLOUD_PROJECT}/orders:1.0.0 ~/monolith-to-microservices/microservices/src/orders
gcloud builds submit --tag gcr.io/${GOOGLE_CLOUD_PROJECT}/products:1.0.0 ~/monolith-to-microservices/microservices/src/products
```

#### Task 4: Deploy the new microservices
```bash
kubectl create deployment orders --image=gcr.io/${GOOGLE_CLOUD_PROJECT}/orders:1.0.0
kubectl expose deployment orders --type=LoadBalancer --port 80 --target-port 8081

kubectl create deployment products --image=gcr.io/${GOOGLE_CLOUD_PROJECT}/products:1.0.0
kubectl expose deployment products --type=LoadBalancer --port 80 --target-port 8082

# check services
ORDERS_EXTERNAL_IP=$(kubectl get svc orders -o jsonpath="{.status.loadBalancer.ingress[0].ip}")
PRODUCTS_EXTERNAL_IP=$(kubectl get svc products -o jsonpath="{.status.loadBalancer.ingress[0].ip}")
curl http://$ORDERS_EXTERNAL_IP/api/orders
curl http://$PRODUCTS_EXTERNAL_IP/api/products
```

#### Task 5: Configure the Frontend microservice
```bash
# reconfigure frontend configuration
cd ~/monolith-to-microservices/react-app
sed -i "s|localhost:8081|${ORDERS_EXTERNAL_IP}|g" .env
sed -i "s|localhost:8082|${PRODUCTS_EXTERNAL_IP}|g" .env

# check configuration
cat .env

# rebuild
npm run build
```

#### Task 6: Create a containerized version of the Frontend microservice
```bash
gcloud builds submit --tag gcr.io/${GOOGLE_CLOUD_PROJECT}/frontend:1.0.0 ~/monolith-to-microservices/microservices/src/frontend
```

#### Task 7: Deploy the Frontend microservice
```bash
kubectl create deployment frontend --image=gcr.io/${GOOGLE_CLOUD_PROJECT}/frontend:1.0.0
kubectl expose deployment frontend --type=LoadBalancer --port 80 --target-port 8080
```