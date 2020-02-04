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
	"method": "item.update",
    	"params": {
        	"itemid": "'$ITEMID'",
		    "history": "120d"
    	},
        "auth": "'$TOKEN'",
        "id": 1
    }
    '

    curl -s -X POST -H "$HEADER" -d "$JSON" "$URL" | python -m json.tool
}

while read linha
do

ITEMID=$(echo $linha | cut -d ":" -f2)

echo $ITEMID
hosts
done < arquivo2


