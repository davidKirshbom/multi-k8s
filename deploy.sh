docker build -t davkir/multi-client:latest -t davkir/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t davkir/multi-server:latest -t davkir/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t davkir/multi-worker:latest -t davkir/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push davkir/multi-client:latest
docker push davkir/multi-server:latest
docker push davkir/multi-worker:latest
docker push davkir/multi-client:$SHA
docker push davkir/multi-server:$SHA
docker push davkir/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=davkir/multi-server:$SHA
kubectl set image deployments/client-deployment client=davkir/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=davkir/multi-worker:$SHA
