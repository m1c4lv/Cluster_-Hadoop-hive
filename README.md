# Cluster_-Hadoop-hive

Este cluster de Hadoop está configurado con un modo de funcionamiento pseudo-distribuido, es decir, en cada uno de los componenetes del cluster se ejecuta su propio contenedor Docker.

## Configuración para Docker-compose:

Primero construimos las imagenes de los contenedores:

```bash
docker build --network host -t hadoop-base Hadoop-base

docker build --network host -t hadoop-namenode Hadoop-namenode

docker build --network host -t hadoop-datanode Hadoop-datanode

docker build --network host -t hadoop-nodemanager Hadoop-nodemanager

docker build --network host -t hadoop-resourcemanager Hadoop-resourcemanager

docker build --network host -t hadoop-historyserver Hadoop-historyserver

docker build --network host -t hadoop-hive Hive
```

Por último, montamos el cluster de Hadoop-Hive con docker-compose:

```bash
docker-compose up -d
```

O bien, para hacer debugging del proceso: 

```bash
docker-compose up --abort-on-container-exit
```

Podemos acceder a cada contenedor con su respectivo nombre:

```bash
docker-compose exec hiveserver bin/bash
 ```

### Ejecutar una prueba de MapReduce en Hadoop:

```bash
docker cp hadoop-mapreduce-examples-3.3.5.jar namenode:/hadoop-mapreduce-examples-3.3.5.jar

docker exec -ti namenode /bin/bash

$HADOOP_HOME/bin/yarn jar hadoop-mapreduce-examples-3.3.5.jar pi 16 1000
```

### Ejecutar prueba en Hive:

```bash
docker exec -ti hiveserver bash

/opt/hive/bin/schematool -initSchema -dbType mysql

/opt/hive/bin/hive

show tables;

create table ejemplo(edad int, nombre string);

show tables;
```

## Configuración para kubernetes:

Primero construimos los pods, aquellos servicios que necesitan persistencia de datos, se lanzan como statefulsets, los que no necesitan persistencia
se lanzan como deployments. Cada servicio tiene su service que le conecta con los demás servicios de Hadoop.

En la carpeta kubernetes-v1 ejecutamos el siguiente comando:

```bash
kubectl apply -f .
```

Podemos acceder a cada pod con su respectivo nombre:

```bash
kubectl exec --stdin --tty hadoop-namenode-0 -- /bin/bash
```

### Ejecutar una prueba de MapReduce en Hadoop:

```bash
kubectl cp hadoop-mapreduce-examples-3.3.5.jar hadoop-namenode-0:/hadoop-mapreduce-examples-3.3.5.jar

kubectl exec --stdin --tty hadoop-namenode-0 -- /bin/bash

$HADOOP_HOME/bin/yarn jar hadoop-mapreduce-examples-3.3.5.jar pi 16 1000
```

### Ejecutar prueba en Hive:

El id de hive-server cambia cada vez que se crea el pod, hay que consultarlo con:

```bash
kubectl get pods
```

Una vez conocido el id del pod hive-server se sustituye en el primer comando, en el id del pod:

```bash
kubectl exec --stdin --tty hive-server-id -- /bin/bash

/opt/hive/bin/schematool -initSchema -dbType mysql

/opt/hive/bin/hive

show tables;

create table ejemplo(edad int, nombre string);

show tables;
```

### Acceder a información del Namenode:

Primero exponemos el servicio al exterior:

```bash
kubectl port-forward hadoop-namenode-0 9870
```

Ahora en el navegador con la direccion: http://localhost:9870/dfshealth.html#tab-overview podemos acceder a la información del namenode.
Como podemos observar están todos los servicios conectados en la versión de Hadoop 3.3.5. 
Si accedemos a la pestaña:Datanodes vemos que tiene un sercicio de Datanode, o lo que es lo mismo, tenemos 1 nodo worker. Vamos a escalar estos servicios, para ello escribimos en otra terminal:

```bash
kubectl scale sts hadoop-datanode --replicas=3
```

Si actualizamos el navegador podemos observar como ahora tenemos tres servicios datanode, cada uno con su almacenamiento y su dirección ip.
