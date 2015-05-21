#!/bin/bash
printf "Exporting env vars...\n"
source /usr/src/app/lib/ahn/.env
export $(cut -d= -f1 /usr/src/app/lib/ahn/.env)
printf "Done.\n"
printf "Installing gems...\n"
cd /usr/src/app && bundle install
printf "Done.\n"
printf "Starting ahn...\n"
ahn start /usr/src/app
printf "Done.\n"
