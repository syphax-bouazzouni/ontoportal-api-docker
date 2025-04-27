bash_cmd="bundle exec unicorn -E production -l 9393"
docker compose run --rm --service-ports api   bash -c "$bash_cmd"
