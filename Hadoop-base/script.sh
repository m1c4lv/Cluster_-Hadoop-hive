#!/bin/bash

##Explanation
##The general format is sed 's/find/replace/'. i.e. find an expression and replace it.
##\( ... \) these are capturing groups. So anything that matches in between them is "captured" in a variable and can be recalled in the replace part, with \1, \2, \3, etc.
##So here, find \(.*("\)\(.*,\)\(.*\)).
##Capturing group 1: .*(". Capture from the beginning to anything that ends with ("
##Capturing group 2: .*,. From #1, capture up to ,.
##Capturing group 3: .*. Capture up to (but not including) ).
##Then replace with the capturing groups and additional formatting \1\3: \2\3).

CORE1="<property><name>fs.default.name</name><value>hdfs://localhost:9000</value></property>\n"
CORE2=$(echo $CORE1 | sed 's/\//\\\//g')

sed -i "/<\/configuration>/ s/.*/${CORE2}&/" /etc/hadoop/core-site.xml

HDFS1="<property><name>dfs.replication</name><value>1</value></property>\n<property><name>dfs.data.dir</name><value>file:///opt/volume/datanode</value></property>\n<property><name>dfs.name.dir</name><value>file:///opt/volume/namenode</value></property>\n"
HDFS2=$(echo $HDFS1 | sed 's/\//\\\//g')

sed -i "/<\/configuration>/ s/.*/${HDFS2}&/" /etc/hadoop/hdfs-site.xml

MAP1="<property><name>mapreduce.framework.name</name><value>yarn</value></property>\n"
MAP2=$(echo $MAP1 | sed 's/\//\\\//g')

sed -i "/<\/configuration>/ s/.*/${MAP2}&/" /etc/hadoop/mapred-site.xml

YARN1="<property><name>yarn.nodemanager.aux-services</name><value>mapreduce_shuffle</value></property>\n"
YARN2=$(echo $YARN1 | sed 's/\//\\\//g')

sed -i "/<\/configuration>/ s/.*/${YARN2}&/" /etc/hadoop/yarn-site.xml 


exec $@
