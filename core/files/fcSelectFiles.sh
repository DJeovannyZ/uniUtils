#!/bin/bash

function selectFiles {
    ranger "$1" --choosefiles=outfiles
  if [ -e outfiles ]; then
    files=$(cat outfiles)
    i=0
    while read -r line; do
        selectedFiles[i]="$line"
        ((i++))
    done <<< "$files"
    rm outfiles
  fi
}

