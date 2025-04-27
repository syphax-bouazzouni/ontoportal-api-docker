docker stack deploy -c compose.yml ontoportal-api
sleep 5
docker logs "$(docker ps -q -f name=ontoportal-api_api | head -n 1)" -f
