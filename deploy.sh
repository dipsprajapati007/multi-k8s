docker build -t dipsprajapati/multi-client:latest -t dipsprajapati/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dipsprajapati/multi-server:latest -t dipsprajapati/multi-server:$SHA -f ./servet/Dockerfile ./server
docker build -t dipsprajapati/multi-worker:latest -t dipsprajapati/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dipsprajapati/multi-client:latest
docker push dipsprajapati/multi-server:latest
docker push dipsprajapati/multi-worker:latest

docker push dipsprajapati/multi-client:$SHA
docker push dipsprajapati/multi-server:$SHA
docker push dipsprajapati/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=dipsprajapati/multi-server:$SHA
kubectl set image deployments/client-deployment client=dipsprajapati/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dipsprajapati/multi-worker:$SHA


