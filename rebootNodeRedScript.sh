#! /bin/bash

echo "Restarting NodeRED Script:     $(date)" >> /var/log/scanner.txt

node-red stop
sleep 10
node-red start

echo "NodeRED Started:     $(date)" >> /var/log/scanner.txt
