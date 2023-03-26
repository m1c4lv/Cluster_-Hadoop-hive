#!/bin/bash

##Explanation
##The general format is sed 's/find/replace/'. i.e. find an expression and replace it.
##\( ... \) these are capturing groups. So anything that matches in between them is "captured" in a variable and can be recalled in the replace part, with \1, \2, \3, etc.
##So here, find \(.*("\)\(.*,\)\(.*\)).
##Capturing group 1: .*(". Capture from the beginning to anything that ends with ("
##Capturing group 2: .*,. From #1, capture up to ,.
##Capturing group 3: .*. Capture up to (but not including) ).
##Then replace with the capturing groups and additional formatting \1\3: \2\3).

CORE1="<property><name>hadoop.proxyuser.hue.hosts</name><value>*</value></property>\n<property><name>fs.defaultFS</name><value>hdfs://namenode:8020</value></property>\n<property><name>hadoop.proxyuser.hue.groups</name><value>*</value></property>\n<property><name>hadoop.http.staticuser.user</name><value>root</value></property>\n"
CORE2=$(echo $CORE1 | sed 's/\//\\\//g')

sed -i "/<\/configuration>/ s/.*/${CORE2}&/" /etc/hadoop/core-site.xml

HDFS1="<property><name>dfs.namenode.name.dir</name><value>file:///hadoop/dfs/name</value></property>\n<property><name>dfs.namenode.datanode.registration.ip-hostname-check</name><value>false</value></property>\n<property><name>dfs.permissions.enabled</name><value>false</value></property>\n<property><name>dfs.webhdfs.enabled</name><value>true</value></property>\n<property><name>dfs.namenode.rpc-bind-host</name><value>0.0.0.0</value></property>\n<property><name>dfs.namenode.servicerpc-bind-host</name><value>0.0.0.0</value></property>\n<property><name>dfs.namenode.http-bind-host</name><value>0.0.0.0</value></property>\n<property><name>dfs.namenode.https-bind-host</name><value>0.0.0.0</value></property>\n<property><name>dfs.client.use.datanode.hostname</name><value>true</value></property>\n<property><name>dfs.datanode.use.datanode.hostname</name><value>true</value></property>\n"
HDFS2=$(echo $HDFS1 | sed 's/\//\\\//g')

sed -i "/<\/configuration>/ s/.*/${HDFS2}&/" /etc/hadoop/hdfs-site.xml

MAP1="<property><name>yarn.nodemanager.bind-host</name><value>0.0.0.0</value></property>\n"
MAP2=$(echo $MAP1 | sed 's/\//\\\//g')

sed -i "/<\/configuration>/ s/.*/${MAP2}&/" /etc/hadoop/mapred-site.xml

YARN1="<property><name>yarn.resourcemanager.fs.state-store.uri</name><value>/rmstate</value></property>\n<property><name>yarn.timeline-service.generic-application-history.enabled</name><value>true</value></property>\n<property><name>yarn.resourcemanager.recovery.enabled</name><value>true</value></property>\n<property><name>yarn.timeline-service.enabled</name><value>true</value></property>\n<property><name>yarn.log-aggregation-enable</name><value>true</value></property>\n<property><name>yarn.resourcemanager.store.class</name><value>org.apache.hadoop.yarn.server.resourcemanager.recovery.FileSystemRMStateStore</value></property>\n<property><name>yarn.resourcemanager.system-metrics-publisher.enabled</name><value>true</value></property>\n<property><name>yarn.nodemanager.remote-app-log-dir</name><value>/app-logs</value></property>\n<property><name>yarn.resourcemanager.resource.tracker.address</name><value>resourcemanager:8031</value></property>\n<property><name>yarn.resourcemanager.hostname</name><value>resourcemanager</value></property>\n<property><name>yarn.timeline-service.hostname</name><value>historyserver</value></property>\n<property><name>yarn.log.server.url</name><value>http://historyserver:8188/applicationhistory/logs/</value></property>\n<property><name>yarn.resourcemanager.scheduler.address</name><value>resourcemanager:8030</value></property>\n<property><name>yarn.resourcemanager.address</name><value>resourcemanager:8032</value></property>\n<property><name>yarn.resourcemanager.bind-host</name><value>0.0.0.0</value></property>\n<property><name>yarn.nodemanager.bind-host</name><value>0.0.0.0</value></property>\n<property><name>yarn.nodemanager.bind-host</name><value>0.0.0.0</value></property>\n<property><name>yarn.timeline-service.bind-host</name><value>0.0.0.0</value></property>\n"
YARN2=$(echo $YARN1 | sed 's/\//\\\//g')

sed -i "/<\/configuration>/ s/.*/${YARN2}&/" /etc/hadoop/yarn-site.xml 


exec $@