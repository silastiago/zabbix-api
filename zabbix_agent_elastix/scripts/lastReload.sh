#!/bin/bash

sudo asterisk -rx 'core show uptime seconds' | awk -F": " '/Last reload/{print$2}'


