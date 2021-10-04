## Easy integration with Filebeat

Filebeat modules simplify the collection, parsing, and visualization of common log formats.
<br>
To start sending logs from your system to logsight.ai via Filebeats you need to execute the following steps:

#### Download the connector script
```
curl -o connect-filebeat.sh https://raw.githubusercontent.com/aiops/connector-filebeat/main/connect-filebeat.sh
```
#### Connect to your system and start sending logs
```
./connect-filebeat.sh -t <private key> -a <application name> -m <module>
```
\<private key\> is your private key which can be found in the Integration and Profile tab inside logsight.ai platform.<br>
\<application name\> is the name of the application you have already created.<br>
\<module\> is the name of the system that you want to connect. For example, if you have running nginx service, the \<module\> will be nginx.

### Supported systems

<div class="ulist itemizedlist">
<ul class="itemizedlist">
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-activemq.html" title="ActiveMQ module"><em>ActiveMQ module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-apache.html" title="Apache module"><em>Apache module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-auditd.html" title="Auditd module"><em>Auditd module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-aws.html" title="AWS module"><em>AWS module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-awsfargate.html" title="AWS Fargate module"><em>AWS Fargate module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-azure.html" title="Azure module"><em>Azure module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-barracuda.html" title="Barracuda module"><em>Barracuda module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-bluecoat.html" title="Bluecoat module"><em>Bluecoat module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-cef.html" title="CEF module"><em>CEF module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-checkpoint.html" title="Check Point module"><em>Check Point module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-cisco.html" title="Cisco module"><em>Cisco module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-coredns.html" title="CoreDNS module"><em>CoreDNS module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-crowdstrike.html" title="Crowdstrike module"><em>Crowdstrike module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-cyberark.html" title="Cyberark module"><em>Cyberark module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-cyberarkpas.html" title="Cyberark PAS module"><em>Cyberark PAS module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-cylance.html" title="Cylance module"><em>Cylance module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-elasticsearch.html" title="Elasticsearch module"><em>Elasticsearch module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-envoyproxy.html" title="Envoyproxy Module"><em>Envoyproxy Module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-f5.html" title="F5 module"><em>F5 module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-fortinet.html" title="Fortinet module"><em>Fortinet module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-gcp.html" title="Google Cloud module"><em>Google Cloud module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-google_workspace.html" title="Google Workspace module"><em>Google Workspace module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-gsuite.html" title="GSuite module"><em>GSuite module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-haproxy.html" title="haproxy module"><em>haproxy module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-ibmmq.html" title="IBM MQ module"><em>IBM MQ module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-icinga.html" title="Icinga module"><em>Icinga module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-iis.html" title="IIS module"><em>IIS module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-imperva.html" title="Imperva module"><em>Imperva module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-infoblox.html" title="Infoblox module"><em>Infoblox module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-iptables.html" title="Iptables module"><em>Iptables module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-juniper.html" title="Juniper module"><em>Juniper module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-kafka.html" title="Kafka module"><em>Kafka module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-kibana.html" title="Kibana module"><em>Kibana module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-logstash.html" title="Logstash module"><em>Logstash module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-microsoft.html" title="Microsoft module"><em>Microsoft module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-misp.html" title="MISP module"><em>MISP module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-mongodb.html" title="MongoDB module"><em>MongoDB module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-mssql.html" title="MSSQL module"><em>MSSQL module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-mysql.html" title="MySQL module"><em>MySQL module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-mysqlenterprise.html" title="MySQL Enterprise module"><em>MySQL Enterprise module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-nats.html" title="nats module"><em>nats module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-netflow.html" title="NetFlow module"><em>NetFlow module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-netscout.html" title="Netscout module"><em>Netscout module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-nginx.html" title="Nginx module"><em>Nginx module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-o365.html" title="Office 365 module"><em>Office 365 module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-okta.html" title="Okta module"><em>Okta module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-oracle.html" title="Oracle module"><em>Oracle module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-osquery.html" title="Osquery module"><em>Osquery module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-panw.html" title="Palo Alto Networks module"><em>Palo Alto Networks module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-pensando.html" title="pensando module"><em>pensando module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-postgresql.html" title="PostgreSQL module"><em>PostgreSQL module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-proofpoint.html" title="Proofpoint module"><em>Proofpoint module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-rabbitmq.html" title="RabbitMQ module"><em>RabbitMQ module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-radware.html" title="Radware module"><em>Radware module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-redis.html" title="Redis module"><em>Redis module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-santa.html" title="Santa module"><em>Santa module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-snort.html" title="Snort module"><em>Snort module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-snyk.html" title="Snyk module"><em>Snyk module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-sonicwall.html" title="Sonicwall module"><em>Sonicwall module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-sophos.html" title="Sophos module"><em>Sophos module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-squid.html" title="Squid module"><em>Squid module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-suricata.html" title="Suricata module"><em>Suricata module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-system.html" title="System module"><em>System module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-threatintel.html" title="Threat Intel module"><em>Threat Intel module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-tomcat.html" title="Tomcat module"><em>Tomcat module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-traefik.html" title="Traefik module"><em>Traefik module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-zeek.html" title="Zeek (Bro) Module"><em>Zeek (Bro) Module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-zookeeper.html" title="ZooKeeper module"><em>ZooKeeper module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-zoom.html" title="Zoom module"><em>Zoom module</em></a>
</li>
<li class="listitem">
<a class="xref" href="https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-zscaler.html" title="Zscaler module"><em>Zscaler module</em></a>
</li>
</ul>
</div>
