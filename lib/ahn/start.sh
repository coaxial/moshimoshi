#!/bin/bash
printf "Installing gems..."
cd /usr/src/app && bundle install
printf "Done."
printf "Starting ahn..."
ahn start /usr/src/app
printf "Done."
