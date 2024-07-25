#!/usr/bin/bash

ip -4 addr show | awk -F : '{print $2}' | grep -E "[a-z0-9]" | awk '{gsub(/[ \t\n\r]/,"");print}'
