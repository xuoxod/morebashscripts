#!/usr/bin/env bash
<<COMMENT
    Administrative helper script use for:
        - Adding user to sudo group
        - Adding user to given group
        - Removing user from sudo group
        - Listing user's group(s)
        - Locking user account
        - Unlocking user account
COMMENT
# declare -r PATH_TEMPLATE='^((/)?([a-zA-Z]+)(/[a-zA-Z]+/?)?$|/)'
# declare -r EXIT_PROG=0
# declare -r ROOT_UID=0
# declare -r NON_ROOT=121
# declare -r EXIT_UNKNOWN_USER=120
# declare -r EXIT_UNKNOWN_GROUP=119
# declare -r PROG="Path Finder"
# declare -r DESC="Administrative helper script use for confirming and/or manipulating paths"

set -e          # Exit if any command has a non-zero exit status
set -u          # Set variables before using them
set -o pipefail # Prevent pipeline errors from being masked
# set -x Prints command to the console
source colortext-lib.sh
source pather-lib.sh
source notifier-lib.sh
source text-generator-lib.sh

clearVars() {
    unset $@ arg
}

gracefulExit() {
    clearVars
    exit 0
}

exitProg() {
    gracefulExit
}

synopsis() {
    text=$(printf "\t\t\t\t $PROG\n")
    white
    printf "$text\n"
    text=$(printf -- '%.0s-' {1..73})
    green
    printf "$text\n"
    text=$(printf "$DESC\n")
    white
    printf "$text\n\n"
}

trap "gracefulExit" INT PWR QUIT TERM

while getopts ':c:pa:g:' OPTION; do
    case "$OPTION" in
    c)
        arg="$OPTARG"
        checkPath "$arg"
        ;;

    a)
        arg="$OPTARG"
        notify "$arg"
        ;;

    p)
        progress
        ;;

    g)
        arg="$OPTARG"
        generatePassword "$arg"
        ;;
    esac
done
shift "$(($OPTIND - 1))"
