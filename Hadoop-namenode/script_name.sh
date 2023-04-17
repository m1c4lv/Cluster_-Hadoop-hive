#!/bin/bash

if ! [ -d /opt/volume/namenode/current ]; then
  echo "Formateando namenode:"
  cd /opt/hadoop-3.3.5/bin/
  hdfs namenode -format
fi
$HADOOP_HOME/bin/hdfs namenode 

