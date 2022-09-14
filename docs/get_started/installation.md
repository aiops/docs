# Local Installation

The [logsight-install](https://github.com/aiops/logsight-install) github repository contains a collection of scripts and other resources helping to install logsight.ai locally.

Clone the repository with git https:
```bash
git clone git@github.com:aiops/logsight-install.git
```

or ssh:

```bash
git clone https://github.com/aiops/logsight-install.git
```

Switch into the ```logsight-install``` directory

```bash
cd logsight-install
```

> [!NOTE]
> If you have cloned the logsight-install repository already, you should check it for updates by runing: git pull

## Installation with docker-compose

We provide all logsight.ai services as [Docker Images](https://hub.docker.com/orgs/logsight/repositories) which you can spin up with docker-compse. All compose, configuration and utility script files are located in the ```docker-compose``` directory.

The easiest way to do the installation is to run the utility script ```install.sh```. You need to accept the EULA when installing logsight.ai by setting ```accept-license``` as the only command line argument for the script.

```bash
./docker-compose/install.sh accept-license
```

The script will prompt for an Elasticsearch and a PostgreSQL password. Alternatively, it is possible to set the following environment variables before running the script.

```bash
export ELASTICSEARCH_PASSWORD=<set a password>
```

```bash
export POSTGRES_PASSWORD=<set a password>
```

The password must comply with some minimum requirements, checked during the installation process.

When all services are running, you can access the logsight.ai landing page via [http://localhost:4200](http://localhost:4200).

## Update with docker-compose

Check the logsight-install repository for updates by running
```bash
git pull
```

You will see changes applied to the installation scripts or `Already up-to-date.` if no updates are available.

To update logsight, run
```bash
./docker-compose/update.sh
```

The most recent logsight containers are used by default. However, it is possible to configure the installation script to use a specific version of logsight. Open the file `./docker-compose/docker-compose/.env`. Search for the entry `DOCKER_IMAGE_TAG=`. The update and installation script will use the version that is defined by that entry.

> [!NOTE]
> **Troubleshooting:** Logsight versions before v1.0.1 are not supporting the update functionality. Updating from version v1.0.0 or before to higher versions is only possible by reinstalling logsight.

## Uninstall with docker-compose

To uninstall logsight run
```bash
./docker-compose/uninstall.sh
```

During the uninstallation you can decide whether to delete the logsight data and docker images.
Deleting logsight data will delete the postgres and elasticsearch database volumes.
