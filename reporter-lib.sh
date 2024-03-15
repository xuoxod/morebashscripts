#!/usr/bin/env bash

report() {
    fileName="$1"
    results="$2"
    touch "./$fileName-report.txt"
    printf "$results" >>"./$fileName-report.txt"
}
