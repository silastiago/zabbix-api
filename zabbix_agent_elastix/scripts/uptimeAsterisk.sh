#!/bin/bash

sudo asterisk -rx "core show uptime seconds" | grep --text -i "System uptime:" | gawk '{print $3}'

