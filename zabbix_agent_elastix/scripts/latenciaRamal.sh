#!/bin/bash

ramal=$1
consulta=$(sudo asterisk -rx 'sip show peer '"${ramal}"'' | egrep Status | grep -Eo "[0-9]{1,9}")
re='^[0-9]+$'

if ! [[ $consulta =~ ^[0-9]+$  ]]
	then
		echo 0
	else
		echo $consulta
fi
