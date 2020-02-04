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

hosts()
{
    JSON='
    {
        "jsonrpc": "2.0",
        "method": "host.get",
        "params": {
            "output": [
                "hostid ",
                "host"
                ],
		 "filter": {
                "status": "1"
                }
        },
        "auth": "'$TOKEN'",
        "id": 1
    }
    '
    
    curl -s -X POST -H "$HEADER" -d "$JSON" "$URL" | awk -v RS='{"' -F\" '/^hostid/ {printf $3 ":" $7 "\n"}'
}

hosts
