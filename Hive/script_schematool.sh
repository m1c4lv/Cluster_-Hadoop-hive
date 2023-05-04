#!/bin/bash

cd $HIVE_HOME/bin
if [ "$(schematool -dbType mysql -info 2>&1 | grep '*** schemaTool failed ***' | wc -l)" -eq 1 ]; then
   schematool -dbType mysql -initSchema
fi
