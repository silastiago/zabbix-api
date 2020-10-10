#!/bin/bash

sudo asterisk -rvvvvvx 'core show channels'| grep --text -i 'active call'| cut -c1
