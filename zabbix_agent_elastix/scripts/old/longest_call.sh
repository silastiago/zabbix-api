#!/bin/bash

CHANNEL="$(sudo asterisk -rx 'core show channels concise' |cut -f12,1 -d'!' |sed 's/!/ /g' |sort -n -k 2 |tail -1)"
CHANNEL_NAME=$(echo $CHANNEL |awk '{print$1}')
CHANNEL_TIME=$(echo $CHANNEL |awk '{print$2}')

if [ -z "$CHANNEL_TIME" ] 
	then
		echo 1
	else
		if [ $CHANNEL_TIME -gt 7200 ]
			then
				sudo asterisk -rx "channel request hangup $CHANNEL_NAME" >> /var/log/asterisk/full
				sleep 1
				if [ "$(sudo asterisk -rx 'core show channels concise' |grep $CHANNEL_NAME)" ]
					then
						echo "$CHANNEL_NAME is $CHANNEL_TIME long"
					else
						echo 1
				fi

			else
				echo 1
		fi
fi
