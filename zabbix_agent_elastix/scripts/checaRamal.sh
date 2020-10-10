#!/bin/bash

ramal=$1

teste=`sudo asterisk -rx 'sip show peers' | egrep $1 | awk  -F' ' '{print $3}'`

if [ "$teste" == "D" ]
	then
	
	consulta=`sudo asterisk -rx 'sip show peers' | egrep $1 | awk  -F' ' '{print $8}'`
		if [ "$consulta" == "OK"  ]
			then
			echo 1
			else
			echo 0
		fi
	else
	consulta=`sudo asterisk -rx 'sip show peers' | egrep $1 | awk  -F' ' '{print $7}'`
		if [ "$consulta" == "OK"  ]
                        then
                        echo 1
                        else
                        echo 0
                fi
fi
