#!/bin/bash

#Crea directorios de Hive dentro del sistema de archivos de Hadoop. El directorio 'warehhouse' es la ubicación para almacenar la tabla o los datos relacionados con Hive
hadoop fs -mkdir       /tmp
hadoop fs -mkdir -p    /user/hive/warehouse
hadoop fs -chmod g+w   /tmp
hadoop fs -chmod g+w   /user/hive/warehouse


cd $HIVE_HOME/bin
./hiveserver2 --hiveconf hive.server2.enable.doAs=false


