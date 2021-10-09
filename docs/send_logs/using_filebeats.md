# Using Filebeat

Filebeat simplifies the collection, parsing, and visualization of common log formats.

To start sending logs from your system to `logsight.ai` via `Filebeats` you need to execute the following steps:

## Download the connector script

```bash
curl -o connect-filebeat.sh https://raw.githubusercontent.com/aiops/connectors/main/filebeat.sh
```

## Start sending logs

Connect to your system and execute the connector script: 

```bash
./connect-filebeat.sh -t <private key> -a <application name> -m <module>
```

+ `<private key>`. Your private key which can be found in the Integration and Profile tab inside logsight.ai platform.
+ `<application name>`. Name of the application you have already created.
+ `<module>`. Name of the system that you want to connect. For example, if you have running nginx service, the \<module\> will be nginx.

Read more about the module of interest in the supported systems bellow.

## Supported systems

|      |      |      |      |      |      |      |      |
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| [ActiveMQ](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-activemq.html) | [Apache](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-apache.html) | [Auditd](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-auditd.html) | [AWS Fargate](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-awsfargate.html) | [Azure](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-azure.html) |
| [Barracuda](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-barracuda.html) | [Bluecoat](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-bluecoat.html)
| [CEF](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-cef.html) | [Check Point](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-checkpoint.html) | [Cisco](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-cisco.html) | [CoreDNS](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-coredns.html) | [Crowdstrike](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-crowdstrike.html) | [Cyberark](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-cyberark.html) | [Cyberark PAS](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-cyberarkpas.html) | [Cylance](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-cylance.html)
| [Elasticsearch](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-elasticsearch.html) | [Envoyproxy](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-envoyproxy.html)
| [F5](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-f5.html) | [Fortinet](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-fortinet.html)
| [Google Cloud](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-gcp.html) | [Google Workspace](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-google_workspace.html) | [GSuite](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-gsuite.html)
| [HAproxy](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-haproxy.html)
| [IBM MQ](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-ibmmq.html) | [Icinga](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-icinga.html) | [IIS](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-iis.html) | [Imperva](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-imperva.html) | [Infoblox](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-infoblox.html) | [Iptables](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-iptables.html) |
| [Juniper](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-juniper.html)
| [Kafka](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-kafka.html) | [Kibana](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-kibana.html)
| [Logstash](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-logstash.html)
| [Microsoft](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-microsoft.html) | [MySQL Enterprise](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-mysqlenterprise.html) |  [MSSQL](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-mssql.html) | [MySQL](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-mysql.html) | [MISP](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-misp.html) | [MongoDB](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-mongodb.html) | 
| [Nats](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-nats.html) | [NetFlow](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-netflow.html) | [Netscout](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-netscout.html) | [Nginx](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-nginx.html)
| [Office 365](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-o365.html) | [Okta](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-okta.html) | [Oracle](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-oracle.html) | [Osquery](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-osquery.html)
| [Palo Alto Networks](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-panw.html) | [Pensando](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-pensando.html) | [PostgreSQL](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-postgresql.html) | [Proofpoint](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-proofpoint.html)
| [RabbitMQ](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-rabbitmq.html) | [Radware](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-radware.html) | [Redis](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-redis.html) |
| [Santa](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-santa.html) | [Snort](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-snort.html) | [Snyk](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-snyk.html) | [Sonicwall](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-sonicwall.html) | [Sophos](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-sophos.html) | [Squid](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-squid.html) | [Suricata](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-suricata.html) | [System](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-system.html) |
| [Threat Intel](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-threatintel.html) | [Tomcat](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-tomcat.html) | [Traefik](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-traefik.html) |
| [Zeek (Bro)](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-zeek.html) | [ZooKeeper](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-zookeeper.html) | [Zoom](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-zoom.html) | [Zscaler](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-zscaler.html) |
