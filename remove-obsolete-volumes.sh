#!/bin/bash
echo "" 
echo "searching for obsolete files on disk. These could be some old volumes deleted from catalog manually..." 
echo "" 
 
cd /mnt/bacula/default
for i in `find . -maxdepth 1 -type f -printf "%f\n"`; do
  echo "list volume=$i" | bconsole | if grep --quiet "No results to list"; then 
  	echo "$i is ready to be deleted"
	rm -f /mnt/bacula/default/$i 
  fi
done
