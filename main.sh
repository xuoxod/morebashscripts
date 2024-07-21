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
source ./actions.sh

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

pflag=
sflag=
start=
final=

while getopts ':?sp' OPTION; do
    case "${OPTION}" in
    p)
        ARGS=$@
        ARG_COUNT=$#
        SCRIPT=$0
        SWITCH=$1
        MSG="\n\n"
        pflag=1

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
        sflag=1
        randomStringGeneratorSynopsis
        ;;

    esac
done

# if [ ! -z "$pflag" ]; then

shift "$(($OPTIND - 1))"

if [[ "$#" -eq 1 ]]; then
    final="$# remaining argument\n"
    printf "#*"
elif [[ "$#" -eq 0 ]] || [[ "$#" -gt 1 ]]; then
    final="$# remaining arguments\n"
fi

if [[ "$#" -gt 1 ]]; then
    printf "$final"
    for A in $@; do
        printf "  $A\n"
    done
    usage
fi
