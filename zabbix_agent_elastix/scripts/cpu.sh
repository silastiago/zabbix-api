#!/bin/bash
# Script para Expansão do monitoramento de processador, incluindo acesso a informações sobre trheads, núcleos físicos, virtuais e etc

# Número de Sockets em uso:

count(){
case $1 in
	sockets)
	if [ "$(info cores)" = "single" ]
        then
		echo $(cat /proc/cpuinfo |grep -i "processor"|sort|uniq|wc -l)
        else
		echo $(cat /proc/cpuinfo|grep -i "physical id"|sort|uniq|wc -l)
        fi
	;;
	cores)
	if [ "$(info cores)" = "single" ]
	then 
#		echo "1"
                # Em casos de processadores single-core, o números de cores é igual ao número de sockets
		echo $(count sockets)
	else
		skt=$(count sockets)
		cor=$(cat /proc/cpuinfo |grep -i "cpu cores"|uniq|sed -s 's/[ ]//g'|cut -d ':' -f 2)
		echo $((skt * cor))
	fi
	;;
	threads)
        if [ "$(info threads)" = "off" ]
        then
#               echo "1"
		# Em casos de processadores single-core, o números de threads é igual ao número de sockets
                echo $(count sockets)
	else
		echo $(cat /proc/cpuinfo |grep -i "siblings"|uniq|sed -s 's/[ ]//g'|cut -d ':' -f 2)
        fi
	;;
	*)
        echo "Count - parâmetro incorreto: $*"
	;;
esac
}

info(){
case $1 in
	cores)
	#Retornar single ou multi
	if [ "$(cat /proc/cpuinfo|grep -i cores;echo $?)" == "1" ]
	then
		echo "single"
	else
		echo "multi"
	fi
	;;
	threads)
        if [ "$(cat /proc/cpuinfo|grep -i siblings;echo $?)" == "1" ]
        then
                echo "off"
        else
                echo "on"
        fi
	;;
	*)
        echo "Info - parâmetro incorreto: $*"
	;;
esac
}

case $1 in
	count)
	count "$2"
	;;
	info)
	info "$2"
	;;
	*)
	echo "Main - parâmetro incorreto: $*"
	;;
esac

