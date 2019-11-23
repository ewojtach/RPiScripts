# Running playbook

- exchange keys with your RPi device to allow ssh connection
- change pi_template.ini to correspond your data, and rename it to pi.ini
- Playbook can be run in two modes: initial RaspberryPi configuration `initialDeployRPi.sh` or just flows and scripts update with `deployRPi.sh` (with skipping tag 'initConfiguration')

```
ansible-playbook install_rpi.yml
```
