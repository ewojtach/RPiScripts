#! /bin/bash

case "$(pidof -x readTempAndMotionDetector.sh | wc -w)" in

0)  echo "Restarting Scanning Script:     $(date)" >> /var/log/scanner.txt
    cd /home/pi/dev/RPiScripts & sudo ./readTempAndMotionDetector.sh
    ;;
2)  # all ok
    echo "Script is running correctly:     $(date)" >> /var/log/scanner.txt
    ;;

esac
