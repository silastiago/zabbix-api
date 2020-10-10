#!/bin/bash


ramal=$1
consulta=$(sudo asterisk -rx 'sip show peer '"${ramal}"'' | egrep Useragent | awk -F': ' '{print $2}')

if [ ! -z  '$(sudo asterisk -rx "sip show peer ${ramal}" | egrep Useragent | awk -F": " "{print $2}")' ]
then
echo $consulta
else
echo "Erro"
fi
