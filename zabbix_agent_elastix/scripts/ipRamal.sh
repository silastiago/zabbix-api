#!/bin/bash

ramal=$1

sudo asterisk -rx "sip show peer $ramal" | egrep Addr | awk -F': ' '{print $2}'
