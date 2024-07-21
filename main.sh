#!/usr/bin/env bash
<<COMMENT
    Helper script
COMMENT

set -e          # Exit if any command has a non-zero exit status
set -u          # Set variables before using them
set -o pipefail # Prevent pipeline errors from being masked
set -m          # enable job control
# set -x Prints command to the console
source constants.sh
source patterns.sh
source actions.sh

ARG=""
MSG=""
SCRIPT=""
ARG_COUNT=0

clearVars() {
    unset ARG MSG SCRIPT
}

gracefulExit() {
    clearVars
    exit "$EXIT_PROG"
}

exitProg() {
    gracefulExit
}

trap "gracefulExit" INT TERM QUIT PWR STOP KILL

while getopts ':?sp' OPTION; do
    case "${OPTION}" in
    p)
        ARGS=$@
        ARG_COUNT=$#
        SCRIPT=$0
        SWITCH=$1
        MSG="\n\n"

        if [[ "$ARG_COUNT" -eq 1 ]]; then
            generateNonpronounceblePassword
        elif [[ "$ARG_COUNT" -eq 2 ]]; then
            ARG1=$2
            if [ "$ARG1" == "off" ]; then
                generatePronounceblePassword
            else
                generateNonpronounceblePassword
            fi
        fi
        ;;

    s)
        randomStringGeneratorSynopsis
        ;;

    esac
done
shift "$(($OPTIND - 1))"
