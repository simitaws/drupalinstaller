#!/bin/bash

clear
echo "Script started ::: [$(date)]"
while true
do
sudo apt update
sudo apt full-upgrade -y
echo "Script run ::: [$(date)]"
sleep 2m
done
