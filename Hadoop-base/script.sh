#!/bin/bash

##Explanation
##The general format is sed 's/find/replace/'. i.e. find an expression and replace it.
##\( ... \) these are capturing groups. So anything that matches in between them is "captured" in a variable and can be recalled in the replace part, with \1, \2, \3, etc.
##So here, find \(.*("\)\(.*,\)\(.*\)).
##Capturing group 1: .*(". Capture from the beginning to anything that ends with ("
##Capturing group 2: .*,. From #1, capture up to ,.
##Capturing group 3: .*. Capture up to (but not including) ).
##Then replace with the capturing groups and additional formatting \1\3: \2\3).

CORE1="<property>\n<name>hadoop.tmp.dir</name>\n<value>/home/hadoop/tmpdata</value>\n</property>\n<property>\n<name>fs.default.name</name>\n<value>hdfs://127.0.0.1:9000</value>\n</property>\n"
CORE2=$(echo $CORE1 | sed 's/\//\\\//g')

sed -i "/<\/configuration>/ s/.*/${CORE2}&/" /etc/hadoop/core-site.xml

HDFS1="<property>\n<name>dfs.data.dir</name>\n<value>/hadoop/dfsdata/namenode</value>\n</property>\n<property>\n<name>dfs.data.dir</name>\n<value>/hadoop/dfsdata/datanode</value>\n</property>\n<property>\n<name>dfs.replication</name>\n<value>1</value>\n</property>\n"
HDFS2=$(echo $HDFS1 | sed 's/\//\\\//g')

sed -i "/<\/configuration>/ s/.*/${HDFS2}&/" /etc/hadoop/hdfs-site.xml

MAP1="<property>\n<name>mapreduce.framework.name</name>\n<value>yarn</value>\n</property>\n"
MAP2=$(echo $MAP1 | sed 's/\//\\\//g')

sed -i "/<\/configuration>/ s/.*/${MAP2}&/" /etc/hadoop/mapred-site.xml

YARN1="<property>\n<name>yarn.nodemanager.aux-services</name>\n<value>mapreduce_shuffle</value>\n</property>\n<property>\n<name>yarn.nodemanager.aux-services.mapreduce.shuffle.class</name>\n<value>org.apache.hadoop.mapred.ShuffleHandler</value>\n</property>\n<property>\n<name>yarn.resourcemanager.hostname</name>\n<value>0.0.0.0</value>\n</property>\n<property>\n<name>yarn.acl.enable</name>\n<value>0</value>\n</property>\n<property>\n<name>yarn.nodemanager.env-whitelist</name>\n<value>JAVA_HOME,HADOOP_COMMON_HOME,HADOOP_HDFS_HOME,HADOOP_CONF_DIR,CLASSPATH_PERPEND_DISTCACHE,HADOOP_YARN_HOME,HADOOP_MAPRED_HOME</value>\n</property>\n"
YARN2=$(echo $YARN1 | sed 's/\//\\\//g')

sed -i "/<\/configuration>/ s/.*/${YARN2}&/" /etc/hadoop/yarn-site.xml 


exec $@