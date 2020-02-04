#!/bin/bash

#URL do server zabbix
URL='http://zabbix.example.com.br/zabbix/api_jsonrpc.php'
HEADER='Content-Type:application/json'

#User frontend
USER='"api"'
#Password on the user api
PASS='"@m$#@&$tthr"'

autenticacao()
{
    JSON='
    {
        "jsonrpc": "2.0",
        "method": "user.login",
        "params": {
            "user": '$USER',
            "password": '$PASS'
        },
        "id": 0
    }
    '
    curl -s -X POST -H "$HEADER" -d "$JSON" "$URL" | cut -d '"' -f8
}
TOKEN=$(autenticacao)

echo $TOKEN
    
hosts()
{
    JSON='
    {
        "jsonrpc": "2.0",
        "method": "hostgroup.get",
        "params": {
            "output": [
                "groupid",
                "name"
                ],
             "selectHosts": [
                "hostid",
                "host"
                ]
        },
        "auth": "'$TOKEN'",
        "id": 1
    }
    '

    #awk 'BEGIN { print "ID    - Host" }'
    curl -s -X POST -H "$HEADER" -d "$JSON" "$URL" | python -m json.tool
    #curl -s -X POST -H "$HEADER" -d "$JSON" "$URL" | awk -v RS='{"' -F\" '/^groupid/ {printf $3 ":" $7 ":" $12 "\n"}' > resultado.txt
    #resultado=$(curl -s -X POST -H "$HEADER" -d "$JSON" "$URL")
    #groupid=$(echo $resultado |  awk -v RS='{"' -F\" '/^groupid/ {printf $3 "\n"}')
    #name=$(echo $resultado |  awk -v RS='{"' -F\" '/^groupid/ {printf $7 "\n"}')
	#curl -s -X POST -H "$HEADER" -d "$JSON" "$URL"
    #echo $resultado
    #echo $groupid "-" $name
    #echo $name
}




hosts






