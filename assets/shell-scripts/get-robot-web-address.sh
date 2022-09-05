echo "Getting frontend service address"
sleep 20s
frontend=$(kubectl get service web --no-headers | awk '{print $4}')

echo $frontend