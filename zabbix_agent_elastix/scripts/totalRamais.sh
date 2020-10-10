#!/bin/bash

sudo asterisk -rx "database show" | grep DEVICE | grep dial | wc -l
