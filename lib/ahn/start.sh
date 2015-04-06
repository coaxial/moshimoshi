#!/bin/bash
printf "Installing gems...\n"
cd /usr/src/app && bundle install
printf "Done.\n"
printf "Starting ahn...\n"
ahn start /usr/src/app
printf "Done.\n"
