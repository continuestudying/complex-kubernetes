docker build -t continuestudying/multi-client:latest -t continuestudying/multi-client:$SHA -f ./client/Dockerfile ./client 
docker build -t continuestudying/multi-server:latest -t continuestudying/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t continuestudying/multi-worker:latest -t continuestudying/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push continuestudying/multi-client:latest
docker push continuestudying/multi-server:latest
docker push continuestudying/multi-worker:latest

docker push continuestudying/multi-client:$SHA
docker push continuestudying/multi-server:$SHA
docker push continuestudying/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=continuestudying/multi-server:$SHA
kubectl set image deployments/client-deployment client=continuestudying/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=continuestudying/multi-worker:$SHA
