#!/bin/bash

quantidadeRamais=`sudo asterisk -rx 'sip show peers' |  sed '1d; $d; s/^ *//' | sed '/Unmonitored/d' | cut -d ' ' -f 1 | cut -f1 -d"/" | wc -w`
Ramais=`sudo asterisk -rx 'sip show peers' |  sed '1d; $d; s/^ *//' | sed '/Unmonitored/d' | cut -d ' ' -f 1 | cut -f1 -d"/"`


echo "{"
echo "\"data\":["

for ramal in $Ramais
do

nome=`sudo asterisk -rx "database show" | grep AMPUSER | grep cidname | grep $ramal | tr '/' ' ' | sed 's/AMPUSER.* ://' | xargs`

if [ "$quantidadeRamais" -le "1" ]
	then
	echo "    {\"{#RAMAL}\":\"$ramal\",\"{#NOME}\":\"$nome\"}"
	else
	echo "    {\"{#RAMAL}\":\"$ramal\",\"{#NOME}\":\"$nome\"},"
	fi
	quantidadeRamais=$(($quantidadeRamais - 1))
done
echo "]"
echo "}"
