## Provisioning API
> **Warning**: This will remove your data
Will create an admin user, and import and parse STY ontology from BioPortal.

```bash
./provision.sh
```

## API check status
```bash
bin/status_check.sh
```

## API management scripts

## Create a new user
```bash
bin/run_cron.sh 'bundle exec rake user:create[username,admin@nodomain.org,password]'
```


## Make a user admin 

```bash
bin/run_cron.sh 'bundle exec rake user:make_admin[username]'
```

## Import an ontology from another OntoPortal instance
```bash
bin/run_cron.sh 'bundle exec bin/ncbo_ontology_import --admin-user username --ontologies <ONTOLOGY_ACRONYM> --from-apikey <API_KEY> --from <API_URL>'"
```

## Process an ontology
```bash
bin/run_cron.sh 'bundle exec bin/ncbo_ontology_process --ontologies <ONTOLOGY_ACRONYM>'
```

