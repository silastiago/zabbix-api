#!/bin/bash

sudo asterisk -rx 'sip show peers' | grep -Eo "Monitored:\ [0-9]{1,9}" | grep -Eo "[0-9]{1,9}"
