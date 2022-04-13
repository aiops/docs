# Logsight.ai local installation

The [logsight-install](https://github.com/aiops/logsight-install) github repository contains a collection of scripts and other resources helping to install logsight.ai locally.

Clone the repository with git https or ssh:
```bash
git clone git@github.com:aiops/logsight-install.git
```

```bash
git clone https://github.com/aiops/logsight-install.git
```

Switch into the ```logsight-install``` directory

```bash
cd logsight-install
```

> [!NOTE]
> If you have cloned the logsight-install repository already, you should check it for updates by runing
> ```bash
> git pull
> ```

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

The password must comply to some minimum requirements, which are checked during the installation process.

When all services are running, you can access the logsight.ai landing page via [http://localhost:4200](http://localhost:4200).
