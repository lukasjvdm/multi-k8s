docker build -t lukasjvdm/multi-client:latest -t lukasjvdm/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lukasjvdm/multi-server:latest -t lukasjvdm/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lukasjvdm/multi-worker:latest -t lukasjvdm/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push lukasjvdm/multi-client:latest
docker push lukasjvdm/multi-server:latest
docker push lukasjvdm/multi-worker:latest

docker push lukasjvdm/multi-client:$SHA
docker push lukasjvdm/multi-server:$SHA
docker push lukasjvdm/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=lukasjvdm/multi-server:$SHA
kubectl set image deployments/client-deployment client=lukasjvdm/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=lukasjvdm/multi-worker:$SHA