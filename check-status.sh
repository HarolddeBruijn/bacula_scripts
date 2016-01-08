#!/usr/bin/env bash
for client in $(echo 'list clients' | bconsole | tail -n +10 | awk -F'|' '{print $3}'); do echo "status client=$client" | bconsole | grep -A 10 '==========' | tail -n 1 | uniq >> /tmp/bacula_clientstatus; done
sort -k7 -k8 /tmp/bacula_clientstatus | uniq > /root/bacula_clientstatus.txt
rm /tmp/bacula_clientstatus
less /root/bacula_clientstatus.txt

