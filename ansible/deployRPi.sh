#!/usr/bin/env bash

chmod 400 ./ssh-key/id_rsa
chmod 750 .
ansible-playbook install_rpi.yml --skip-tags "initConfiguration"
