docker build -t anderhi/multi-client:latest -t anderhi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t anderhi/multi-server:latest -t anderhi/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t anderhi/multi-worker:latest -t anderhi/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push anderhi/multi-client:latest
docker push anderhi/multi-server:latest
docker push anderhi/multi-worker:latest

docker push anderhi/multi-client:$SHA
docker push anderhi/multi-server:$SHA
docker push anderhi/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=anderhi/multi-server:$SHA
kubectl set image deployments/client-deployment client=anderhi/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=anderhi/multi-worker:$SHA