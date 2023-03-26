# Cluster_-Hadoop-hive

Primero construimos las imagenes de los contenedores:
docker build --network host -t hadoop-base .
docker build --network host -t hadoop-name .
docker build --network host -t hadoop-data .
docker build --network host -t hadoop-hive .

Por último, montamos el cluster de Hadoop-Hive con docker-compose:
docker-compose up -d

O bien: docker-compose up --abort-on-container-exit

Podemos acceder a cada contenedor con su respectivo nombre:
docker-compose exec hiveserver bin/bash  
