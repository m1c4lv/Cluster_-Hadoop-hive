FROM debian:11

#Instala herramientas necesarias para el contenedor
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      net-tools \
      curl \
      netcat \
      gnupg \
      ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Instala java8
RUN set -x \
    && curl -fSL "https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u372-b07/OpenJDK8U-jdk_x64_linux_hotspot_8u372b07.tar.gz" -o /tmp/jdk8.tar.gz \
    && tar -xvf /tmp/jdk8.tar.gz -C /opt/ \
    && rm /tmp/jdk8.tar.gz

ENV JAVA_HOME=/opt/jdk8u372-b07/
ENV PATH=$PATH:$JAVA_HOME/

# Instala miniconda con python3.7 y mrjob0.7.4
ENV CONDA_URL https://repo.anaconda.com/miniconda/Miniconda3-py37_23.1.0-1-Linux-x86_64.sh
RUN set -x \
    && curl -fSL "$CONDA_URL" -o /tmp/conda.sh \
    && /bin/bash /tmp/conda.sh -b -p /opt/anaconda \
    && rm /tmp/conda.sh*
ENV PATH $PATH:/opt/anaconda/bin
RUN pip install mrjob

#Instala Hadoop3.3.5
RUN curl -O https://dist.apache.org/repos/dist/release/hadoop/common/KEYS

RUN gpg --import KEYS

ENV HADOOP_VERSION 3.3.5
ENV HADOOP_URL https://www.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz

RUN set -x \
    && curl -fSL "$HADOOP_URL" -o /tmp/hadoop.tar.gz \
    && curl -fSL "$HADOOP_URL.asc" -o /tmp/hadoop.tar.gz.asc \
    && gpg --verify /tmp/hadoop.tar.gz.asc \
    && tar -xvf /tmp/hadoop.tar.gz -C /opt/ \
    && rm /tmp/hadoop.tar.gz*

RUN ln -s /opt/hadoop-$HADOOP_VERSION/etc/hadoop /etc/hadoop

RUN mkdir /opt/hadoop-$HADOOP_VERSION/logs

RUN mkdir /hadoop-data

## HADOOP env variables
ENV HADOOP_HOME=/opt/hadoop-$HADOOP_VERSION
ENV HADOOP_COMMON_HOME=$HADOOP_HOME
ENV HADOOP_HDFS_HOME=$HADOOP_HOME
ENV HADOOP_MAPRED_HOME=$HADOOP_HOME
ENV HADOOP_YARN_HOME=$HADOOP_HOME
ENV HADOOP_OPTS=-Djava.library.path=$HADOOP_HOME/lib/native
ENV HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
ENV HADOOP_CLASSPATH=/opt/hadoop-3.3.5/etc/hadoop:/opt/hadoop-3.3.5/share/hadoop/common/lib/*:/opt/hadoop-3.3.5/share/hadoop/common/*:/opt/hadoop-3.3.5/share/hadoop/hdfs:/opt/hadoop-3.3.5/share/hadoop/hdfs/lib/*:/opt/hadoop-3.3.5/share/hadoop/hdfs/*:/opt/hadoop-3.3.5/share/hadoop/mapreduce/*:/opt/hadoop-3.3.5/share/hadoop/yarn:/opt/hadoop-3.3.5/share/hadoop/yarn/lib/*:/opt/hadoop-3.3.5/share/hadoop/yarn/*:/opt/hadoop-3.3.5/share/hadoop/tools/lib/*
ENV PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin
ENV HDFS_NAMENODE_USER=root
ENV HDFS_DATANODE_USER=root
ENV HDFS_SECONDARYNAMENODE_USER=root
ENV YARN_RESOURCEMANAGER_USER=root
ENV YARN_NODEMANAGER_USER=root
ENV HADOOP_CONF_DIR=/opt/hadoop-3.3.5/etc/hadoop

ADD conf/* /etc/hadoop/
