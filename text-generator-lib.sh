#!/usr/bin/env bash

generatePassword() {
    color -w '\n\tGenerating password ...\n'
    sleep 2
    apg -a 1 -M Sncl -m 17 -n 1 -E +\<\>\;:\|\\\^\'\",\.\={}*\-[]\`\~\)\(\/
    gracefulExit
}
