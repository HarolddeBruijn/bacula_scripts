#!/bin/bash
echo "" 
echo "searching for all purged volumes to be deleted..." 
echo "" 
PURGED_VOLUMES=`echo "list volumes" | bconsole | grep "Purged" | awk {'print $4'}` 
echo "$PURGED_VOLUMES" 
echo "" 
echo -n "Are you sure you want to delete all these purged volumes from Bacula catalog ? (yes|no): " 
read response 
if [ $response = "yes" ]; 
	then BACULA_BATCH="$(mktemp)" 
	rm -f /tmp/bacula.log 
	echo "@output /tmp/bacula.log" > $BACULA_BATCH 
	echo "$PURGED_VOLUMES" | while read I; do 
		echo "delete volume=$I" >> $BACULA_BATCH 
		echo "yes" >> $BACULA_BATCH 
	done 
	bconsole < $BACULA_BATCH 
	rm -f $BACULA_BATCH 
	echo "Done. See the log file /tmp/bacula.log" 
fi
