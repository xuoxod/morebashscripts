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
declare -r MAINPROGNAME="Admin Helper"
declare MAIN="$MAINPROGNAME"
declare -r MAINDESCRIPTION="Administrative helper script used as a short-cut to calling BASH commands"
declare -r MAINDESC="$MAINDESCRIPTION"

set -e          # Exit if any command has a non-zero exit status
set -u          # Set variables before using them
set -o pipefail # Prevent pipeline errors from being masked
# set -x Prints command to the console
source colortext-lib.sh
source pather-lib.sh
source notifier-lib.sh
source text-generator-lib.sh
source reporter-lib.sh
source scriptcompiler.sh

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
    text=$(printf "\t\t\t\t ${MAIN}\n")
    white
    printf "$text\n"
    text=$(printf -- '%.0s-' {1..73})
    green
    printf "$text\n"
    text=$(printf "$MAINDESC\n")
    white
    printf "$text\n"
    text=$(printf "Synopsis:  $0 -<[capgrsh]>\n\tc: Confirm path\n\ta: Create an alert\n\tg: Generate a password\n\tr: Create a report text file\n\t   Requires 2 arguments - arg1: File name, arg2: The text data\n\ts: Compile a shell script file\n")
    white
    printf "$text\n"
    text=$(printf -- '%.0s-' {1..73})
    green
    printf "$text\n"
}

trap "gracefulExit" INT PWR QUIT TERM

while getopts ':c:pr:a:g:s:' OPTION; do
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

    r)
        arg="$OPTARG"
        if [ $# -eq 3 ]; then
            arg3="$3"
            report "$arg" "$arg3"
        fi
        ;;

    s)
        arg="$OPTARG"
        compileScript "$arg"
        ;;

    *)
        synopsis
        ;;
    esac
done
shift "$(($OPTIND - 1))"
