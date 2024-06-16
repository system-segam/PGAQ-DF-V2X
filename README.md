# PGAQ-DF-V2X
Privacy-Preserving Group-by-Aggregation Queries for Data Federation under V2X environment.

## Requirements

- Ubuntu 18.04
- Docker

- Java 11
- Apache Maven 3.6.0+

**Note:** The system has been tested on Ubuntu, but theoretically, it is also applicable to other operating systems such as macOS and Windows.

## Quick Start

- First, ensure that the above requirements are installed.
- Granting Docker permissions to the account (optional). You can try running "docker run hello-world". If you don't see the message "Permission Denied", then there's no need to proceed with this step.

```shell
# Verify the existence of the Docker group
cat /etc/group | grep docker

# If the Docker group is not present in the output, please create the group.
sudo groupadd docker

# Add the current user to the Docker group.
sudo usermod -aG docker $USER
```

- Clone the git repository

```shell
git clone git@github.com:system-segam/PPGAQ-DF-V2X.git
cd segam
```

- Deploying three data owners using Docker and initializing them.

```shell
docker pull postgres:13
# Package and deploy
chmod +x ./package.sh && ./package.sh
chmod +x ./deploy.sh && ./deploy.sh
```

- You can verify whether the data container has been initialized successfully by executing the following command. 

```shell
# If it displays the Java version and the number of rows in the data table correctly, it indicates successful initialization.

docker exec -u postgres container1 bash -c 'java --version && psql postgres -c "select count(*) from lineitem"'
docker exec -u postgres container2 bash -c 'java --version && psql postgres -c "select count(*) from lineitem"'
docker exec -u postgres container3 bash -c 'java --version && psql postgres -c "select count(*) from lineitem"'
```

- Start up all data owner services.

```shell
cd release
./start-server.sh
```

- Start up query side service.

```shell
# You can view the parameter instructions by using java -jar core.jar -h
java -jar core.jar test_sum.sql
```

## Run your own query

If you wish to query your own data, the following steps should be performed, along with modifications to certain configuration files as outlined below.

1. Build multiple Docker containers with configurations including Postgres 13+ and Java 11+, and map port 9991 of the container (which can be specified by modifying the `serverPort` item in `container/config.json`) to a custom port on the host machine.
2. Modify the `release/config.json` file to represent each container using the "local network IP of the host machine + the port number mapped to the host machine" obtained from the previous step.
3. Modify the `release/container/config.json` file to configure the access method for the corresponding container databases.

