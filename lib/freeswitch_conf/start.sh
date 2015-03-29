#!/bin/bash

printf "Copying FreeSWITCH's config...\n"
cp -R /usr/src/freeswitch_conf /etc/freeswitch/
printf 'Done.\n'

printf 'Determining internal_ip value...\n'
if [ "$(ping 192.168.59.103 -c 1 -w 1 | grep '100%')" = "" ]; then
  INTERNAL_IP='192.168.59.103'
else
  INTERNAL_IP='$${local_ip_v4}'
fi

printf "internal_ip = ${INTERNAL_IP}\n"

(
  printf '<include>\n'
  printf "  <X-PRE-PROCESS cmd=\"set\" data=\"internal_ip=${INTERNAL_IP}\"/>\n"
  printf '  <X-PRE-PROCESS cmd="set" data="lan_ip=$${local_ip_v4}"/>\n'
  printf '</include>'
) > /etc/freeswitch/hosts/internal_ip.xml

printf 'Starting FS...\n'
freeswitch

