# Deploy OntoPortal API and UI in a server
<img width="1495" alt="image" src="https://github.com/user-attachments/assets/10dc2feb-2e33-49c7-ae7a-55c68a43a88d" />

### Pre-requisites
    * Docker
    * Ram > 8GB
    * Space > 5GB

### Steps
#### Clone the repo
```bash
git clone https://github.com/syphax-bouazzouni/ontoportal-swarm-docker.git
cd ontoportal-swarm-docker
```
#### Init Docker Swarm
```bash
docker swarm init
```


#### Create a shared network for the API and UI
```bash
docker network create --driver=overlay --attachable --opt encrypted shared-network
```

#### Create an .env file and edit it with your own values
```bash
cp .env.sample .env
```

#### Deploy the API stack
```bash
docker stack deploy -c api.compose.yml ontoportal-api
```

#### Deploy the UI stack
```bash
docker stack deploy -c ui.compose.yml ontoportal-ui
```

#### (OPTIONAL) Deploy Swarmpit to help manage and monitor the swarm cluster
```bash
 docker run -it --rm \                              
  --name swarmpit-installer \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  swarmpit/install:1.9
```

#### Provisioning admin user and importing STY
```bash
# Create the admin user with a random password
docker exec -it $(docker ps -q -f name=ontoportal-api_ncbo_cron) bash -c './provision/create_admin_user.sh'
```
```bash
# Import and parse the STY ontology from the NCBO BioPortal
docker exec -it $(docker ps -q -f name=ontoportal-api_ncbo_cron) bash -c './provision/create_parse_sty.sh'
```


