#! /usr/bin/bash

for I in $(ip -4 addr show | awk -F : '{print $2}' | grep -E "[a-z0-9][^\b(lo)\b]{2}" | awk '{gsub(/[ \t\n\r]/,"");print}'); do
    ip -4 addr show "$(I)" | grep -E "inet (([0-9])\.){4}*" | awk '{print $2}' | awk -F "/" '{print $1}'
done
