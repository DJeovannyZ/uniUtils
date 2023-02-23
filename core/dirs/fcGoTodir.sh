#!/bin/bash

function goToDir {
    selectedDir
    cd "$selectedDir"
    exec zsh
}

