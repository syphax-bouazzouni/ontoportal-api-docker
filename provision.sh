source .env
echo "[+] Running Cron provisioning"

docker compose pull
docker compose down --volumes
date=$(date +%Y-%m-%d)
zip -r ./data-backup-$date.zip ./data
rm -fr ./data

random_password=$(openssl rand -hex 12)

commands=(
        "bin/run_cron.sh 'bundle exec rake user:create[admin,admin@nodomain.org,$random_password]'"
        "bin/run_cron.sh 'bundle exec rake user:adminify[admin]'"
        "bin/run_cron.sh 'bundle exec bin/ncbo_ontology_import --admin-user admin --ontologies $STARTER_ONTOLOGY --from-apikey $OP_APIKEY --from $OP_API_URL'"
        "bin/run_cron.sh 'bundle update && bundle exec bin/ncbo_ontology_process -o ${STARTER_ONTOLOGY}'"
)
for cmd in "${commands[@]}"; do
  echo "[+] Run: $cmd"
        if ! eval "$cmd"; then
            echo "Error: Failed to run provisioning .  $cmd"
            exit 1
        fi
done
echo "CRON Setup completed successfully!"