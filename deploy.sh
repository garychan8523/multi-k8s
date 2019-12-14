docker build -t garychan8523/multi-client:latest -t garychan8523/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t garychan8523/multi-server:latest -t garychan8523/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t garychan8523/multi-worker:latest -t garychan8523/multi-worker:$SHA  -f ./worker/Dockerfile ./worker

docker push garychan8523/multi-client:latest
docker push garychan8523/multi-server:latest
docker push garychan8523/multi-worker:latest

docker push garychan8523/multi-client:$SHA
docker push garychan8523/multi-server:$SHA
docker push garychan8523/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=garychan8523/multi-server:$SHA
kubectl set image deployments/client-deployment client=garychan8523/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=garychan8523/multi-worker:$SHA