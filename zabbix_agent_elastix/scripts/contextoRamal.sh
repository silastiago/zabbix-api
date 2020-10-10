#!/bin/bash

ramal=$1
sudo asterisk -rx 'sip show peer '"${ramal}"'' | egrep Context | sed 's/Context.* ://' | xargs
