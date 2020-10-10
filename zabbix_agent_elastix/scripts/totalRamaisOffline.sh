#!/bin/bash

sudo asterisk -rx 'sip show peers' | grep -Eo "[0-9]{1,9}\ offline Unmonitored" | grep -Eo "[0-9]{1,9}"
