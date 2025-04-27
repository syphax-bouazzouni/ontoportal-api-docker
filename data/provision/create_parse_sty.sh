echo "Importing Ontology $STARTER_ONTOLOGY from $OP_API_URL"
bundle exec bin/ncbo_ontology_import --admin-user admin --ontologies $STARTER_ONTOLOGY --from-apikey $OP_APIKEY --from $OP_API_URL > /dev/null
echo "Processing Ontology $STARTER_ONTOLOGY"
bundle exec bin/ncbo_ontology_process -o $STARTER_ONTOLOGY
