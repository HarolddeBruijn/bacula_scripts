#!/bin/bash
clients=`mysql -e'select Name from Client ORDER BY Name ASC;' bacula | tail -n+2`
for client in `echo $clients`
do 
  echo "prune files client=${client} yes" | bconsole
done 
