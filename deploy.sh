docker build -t 3323/multi-client:latest -t 3323/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t 3323/multi-server:latest -t 3323/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t 3323/multi-worker:latest -t 3323/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push 3323/multi-client:latest
docker push 3323/multi-server:latest
docker push 3323/multi-worker:latest

docker push 3323/multi-client:$SHA
docker push 3323/multi-server:$SHA
docker push 3323/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server-cont=3323/multi-server:$SHA
kubectl set image deployments/frontend-deployment frontend-cont=3323/multi-client:$SHA
kubectl set image deployments/worker-deployment worker-cont=3323/multi-server:$SHA