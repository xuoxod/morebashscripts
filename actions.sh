#!/usr/bin/env bash
<<COMMENT
    Command helper
COMMENT
# declare -r EXIT_PROG=0
# declare -r ROOT_UID=0
# declare -r NON_ROOT=121
# declare -r EXIT_UNKNOWN_USER=120
# declare -r EXIT_UNKNOWN_GROUP=119
# declare -r PROG=""
# declare -r DESC="Administrative helper script use for confirming and/or manipulating paths"

# set -e          # Exit if any command has a non-zero exit status
# set -u          # Set variables before using them
# set -o pipefail # Prevent pipeline errors from being masked
# set -m
# # set -x Prints command to the console
# source patterns.sh

# MSG=""
# ARG1=""

clearVars() {
    unset ARG1 MSG
}

gracefulExit() {
    clearVars
    exit 0
}

exitProg() {
    gracefulExit
}

generatePronounceblePassword() {
    color -w '\n\tGenerating pronouncable string ...\n'
    sleep 2
    apg -a 0 -M Sncl -m 17 -n 1 -E +\<\>\;:\|\\\^\'\",\.\={}*\-[]\`\~\)\(\/
    gracefulExit
}

generateNonpronounceblePassword() {
    color -w '\n\tGenerating non-pronouncable string ...\n'
    sleep 2
    apg -a 1 -M Sncl -m 17 -n 1 -E +\<\>\;:\|\\\^\'\",\.\={}*\-[]\`\~\)\(\/
    gracefulExit
}

gpp() {
    generatePronounceblePassword
}

gnp() {
    generateNonpronounceblePassword
}

usage() {
    printf "\nUsage:\t $0 -<[ps]> [off]\n  Notice optional argument is without a dash or double dash\n\n"
    exitProg
}

randomStringGeneratorSynopsis() {
    printf " \nSynopsis:\t $0 <[OPTION]> [ARGUMENT]\n\n"
    printf "Usage:\t $0 - <[ps]> [argument]\n\n\n"
    printf "Options:\n\n"
    printf "\t-p:   Generate a random non-pronouncable string.\n"
    printf "\n\t          Example:\n"
    printf "\n\t               $0 -p off\n\n"
    exitProg
}

endProg() {
    printf "$MSG"
    gracefulExit
}

# Display network cards
displayNCards() {
    sudo lshw -class network
}

displayNCardsShort() {
    sudo lshw -class network -short
}

displayEth() {
    # sudo apt install ethtool -y
    for N in $(netface); do
        sudo ethtool "$N"
        printf "\n\n"
    done
}

# trap "gracefulExit" INT TERM QUIT PWR STOP KILL

# while getopts ':?sp' OPTION; do
#     case "${OPTION}" in
#     p)
#         ARGS=$@
#         ARG_COUNT=$#
#         SCRIPT=$0
#         SWITCH=$1
#         MSG="\n\n"

#         if [[ "$ARG_COUNT" -eq 1 ]]; then
#             printf "Generating non-pronouncable string ...\n\n"
#         elif [[ "$ARG_COUNT" -eq 2 ]]; then
#             ARG1=$2
#             printf "Argument Provided: $ARG1\n"

#             if [ "$ARG1" == "off" ]; then
#                 printf "Generating pronouncable string ...\n\n"
#             else
#                 printf "Generating non-pronouncable string ...\n\n"
#             fi
#         fi
#         ;;

#     s)
#         randomStringGeneratorSynopsis
#         ;;

#     esac
# done
# shift "$(($OPTIND - 1))"

# endProg
