# Datos del proyecto

UNIVERSIDAD NACIONAL DE EDUCACIÓN A DISTANCIA

ESCUELA TÉCNICA SUPERIOR DE INGENIERÍA INFORMÁTICA

Proyecto de fin de Grado en Ingeniería Informatica:

**Virtualización ligera y cloud computing para el despliegue de infraestructuras Big Data para la docencia online de Ingeniería**

Miguel Carrillo Álvarez

Dirigido por: Agustín Carlos Caminero Herráez

Curso 2022/2023, convocatoria Junio

# Cluster_-Hadoop-hive

Este cluster de Hadoop está configurado con un modo de funcionamiento pseudo-distribuido, es decir, en cada uno de los componenetes del cluster se ejecuta su propio contenedor Docker.

## Configuración para Docker-compose:

Podemos construir las imagenes de los contenedores o descargalarlas directamente de DockerHub: https://hub.docker.com/repositories/m1c4lv

```bash
docker build --network host -t hadoop-base Hadoop-base

docker build --network host -t hadoop-namenode Hadoop-namenode

docker build --network host -t hadoop-datanode Hadoop-datanode

docker build --network host -t hadoop-nodemanager Hadoop-nodemanager

docker build --network host -t hadoop-resourcemanager Hadoop-resourcemanager

docker build --network host -t hadoop-historyserver Hadoop-historyserver

docker build --network host -t hadoop-hive Hive

docker build --network host -t hadoop-jupyter Hadoop-Jupyter
```

Para montar el cluster de Hadoop-Hive con docker-compose:

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

/opt/hive/bin/hive

show tables;

create table ejemplo(edad int, nombre string);

show tables;
```

## Configuración para kubernetes:

Este Cluster de Hadoop se ha construido sobre minikube, por tanto para hacerlo funcionar hay que tener instalado minikube, una vez instalado hacemos:

```bash
minikube start
minikube addons enable ingress
```

Primero construimos los pods, aquellos servicios que necesitan persistencia de datos, se lanzan como statefulsets, los que no necesitan persistencia
se lanzan como deployments. 
Cada servicio tiene su service que le conecta con los demás servicios de Hadoop. Y los pods que necesitan exponer puertos al exterior tienen un ingress cada uno.

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

/opt/hive/bin/hive

show tables;

create table ejemplo(edad int, nombre string);

show tables;
```

### Acceder a información del Namenode:

Primero exponemos el ingress al exterior:

```bash
minikube tunnel
```

Ahora en el navegador con la direccion: http://namenode.127.0.0.1.nip.io/ podemos acceder a la información del namenode.
Como podemos observar están todos los servicios conectados en la versión de Hadoop 3.3.5. 
Si accedemos a la pestaña:Datanodes vemos que tiene tres sercicios de Datanode, o lo que es lo mismo, tenemos 3 nodo worker.

En el navegador podemos acceder al Yarn (servicio ResourceManager) con la dirección: http://resourcemanager.127.0.0.1.nip.io/

Podemos acceder a hive-server donde se nos muestra todo lo que está ocurriendo en hiveserver2 cuando conectamoe con él mediante beeline: http://hiveserver.127.0.0.1.nip.io/

También podemos acceder a JupyterNotebooks con la dirección: http://jupyter.127.0.0.1.nip.io/ nos pedirá el token, el cual lo podemos obtener accediendo a los logs del pod hadoop-jupyter.

```bash
kubectl logs hadoop-jupyter-0
```

