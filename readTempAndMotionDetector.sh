#!/bin/bash

declare -i cnt
declare -i dcnt
declare -i bcnt
declare -i tl
declare -i bl
declare -i bc
declare -i btALARMY
declare -i DTYPE
declare -A measureArr
declare -A alertArr

if [[ $1 == "parse" ]]; then
  packet=""
  capturing=""
  count=0
  while read line
  do
    count=$[count + 1]
    if [ "$capturing" ]; then
      if [[ $line =~ ^[0-9a-fA-F]{2}\ [0-9a-fA-F] ]]; then
        packet="$packet $line"
      else
 # echo RAW: $packet
	cnt=0
	dcnt=0
	bl=0
	bt=0
        bc=0
	np=""
	mp=""

	DTYPE=0

        for i in $packet; do
            if [[ "$cnt" -eq "13" ]]; then
	      tl=`echo "ibase=16; $i"|bc`
	      #echo TL $tl
            fi
            if [[ "$cnt" -gt "13" ]]; then
	      np+=$i
	      if [[ "$bl" -eq "0" ]]; then
		#echo DTYPE: $DTYPE
		if [[ "$DTYPE" -eq "145" ]]; then # iNode Care 1 sensor /motion and temp/
		# echo DTYPE

	   MAC=`echo $packet | awk '{print $13$12$11$10$9$8}'`
	               #echo mp: $mp
			#ALARMY
			#MOVE_FLAG=`echo $((16#8192))`

                        HEX=`echo $mp | awk '{ print $8$7 }'`
			DEC=`echo "ibase=16; $HEX"|bc`
			ALARM=$DEC
			#echo ALARM:  $HEX $DEC
			if [[ "$DEC" -eq "1" ]]; then
				echo ALARM!!!!!!!!!!!!!!!!!!!!!!!!!!
				# omxplayer -o local police_s.wav
        			
				if [[ "$DEC" -ne "${alertArr[$MAC]}" ]]; then
					echo nowy alarm
					alertArr[$MAC]=$DEC
       					curl -i -H "Accept: application/json" -H "Content-Type: application/json" http://localhost:1880/alert?sensor=$MAC\&value=$ALARM
				
				fi				

				
			fi
			alertArr[$MAC]=$DEC


		  #temperature

			CONSTDEC=`echo $((16#8192))`

			#echo consstdec: $CONSTDEC

		        HEX=`echo $mp | awk '{ print $12$11 }'`
			DEC=$(( 16#$HEX&16#3FF ))
			TEMP=$(($DEC/16))
			if [[ "$TEMP" -gt "127" ]]; then
				TEMP=`expr $TEMP - $CONSTDEC`
			fi
			if [[ "$TEMP" -ne "${measureArr[$MAC]}" ]]; then
				echo nowa wartosc
				measureArr[$MAC]=$TEMP
       				curl -i -H "Accept: application/json" -H "Content-Type: application/json" http://localhost:1880/measure?sensor=$MAC\&value=$TEMP
			fi

      #logowanie do lokalnego sysloga
      logger TEMP: $TEMP ALARM: $ALARM local.info
      #print na ekranie
	    echo MAC: $MAC TEMP: $TEMP ALARM: $ALARM | awk -v data="$(date +"%Y-%m-%d %H:%M:%S")" '{print data, $0; fflush();}'
		  DTYPE=0
	  fi

		if [[ "$dcnt" -lt "$tl" ]]; then
		  bl=`echo "ibase=16; $i"|bc`
	          bcnt=0
		  #echo BL $bl
  		  mp=$i" "
    fi
	  else if [[ "$bcnt" -eq "0" ]]; then
		  bc=`echo "ibase=16; $i"|bc`
		  #echo BC $bc
		fi
		if [[ "$bc" -eq "255" ]]; then
	          if [[ "$bcnt" -eq "2" ]]; then
		    DTYPE=`echo "ibase=16; $i"|bc`

		    #echo DTYPE $DTYPE
		  fi
		fi

		bcnt=$bcnt+1

		bl=$bl-1

		mp+=$i" "
	fi
	dcnt=$dcnt+1
fi
cnt=$cnt+1
done

        capturing=""
        packet=""
      fi
    fi

    if [ ! "$capturing" ]; then
      if [[ $line =~ ^\> ]]; then
        packet=`echo $line | sed 's/^>.\(.*$\)/\1/'`
        capturing=1
      fi
    fi
  done
else
  hcitool lescan --duplicates --passive 1>/dev/null &
  if [ "$(pidof hcitool)" ]; then
    hcidump --raw | ./$0 parse $1
  fi
fi
