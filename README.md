# Cluster_-Hadoop-hive

Este cluster de Hadoop está configurado con un modo de funcionamiento pseudo-distribuido, es decir, en cada uno de los componenetes del cluster se ejecuta su propio contenedor Docker.
Primero construimos las imagenes de los contenedores:
docker build --network host -t hadoop-base Hadoop-base
docker build --network host -t hadoop-namenode Hadoop-namenode
docker build --network host -t hadoop-datanode Hadoop-datanode
docker build --network host -t hadoop-nodemanager Hadoop-nodemanager
docker build --network host -t hadoop-resourcemanager Hadoop-resourcemanager
docker build --network host -t hadoop-historyserver Hadoop-historyserver
docker build --network host -t hadoop-hive Hive

Por último, montamos el cluster de Hadoop-Hive con docker-compose:
docker-compose up -d
O bien: docker-compose up --abort-on-container-exit

Podemos acceder a cada contenedor con su respectivo nombre:
docker-compose exec hiveserver bin/bash
 
Ejecutar una prueba de MapReduce en Hadoop:

docker cp hadoop-mapreduce-examples-3.3.5.jar namenode:/hadoop-mapreduce-examples-3.3.5.jar
docker exec -ti namenode /bin/bash
$HADOOP_HOME/bin/yarn jar hadoop-mapreduce-examples-3.3.5.jar pi 16 1000

Ejecutar prueba en Hive:

docker exec -ti hiveserver bash
/opt/hive/bin/schematool -initSchema -dbType mysql
/opt/hive/bin/hive
show tables;
create table ejemplo(edad int, nombre string);
show tables;

