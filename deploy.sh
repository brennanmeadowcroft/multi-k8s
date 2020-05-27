docker build -t brennanmeadowcroft/multi-client:latest -t brennanmeadowcroft/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t brennanmeadowcroft/multi-server:latest -t brennanmeadowcroft/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t brennanmeadowcroft/multi-worker:latest -t brennanmeadowcroft/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push brennanmeadowcroft/multi-client:latest
docker push brennanmeadowcroft/multi-server:latest
docker push brennanmeadowcroft/multi-worker:latest

docker push brennanmeadowcroft/multi-client:$GIT_SHA
docker push brennanmeadowcroft/multi-server:$GIT_SHA
docker push brennanmeadowcroft/multi-worker:$GIT_SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=brennanmeadowcroft/multi-client:$GIT_SHA
kubectl set image deployments/server-deployment server=brennanmeadowcroft/multi-server:$GIT_SHA
kubectl set image deployments/worker-deployment worker=brennanmeadowcroft/multi-worker:$GIT_SHA