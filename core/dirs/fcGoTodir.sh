#!/bin/bash

function goToDir {
    selectDir
    cd "$selectedDir"
    exec zsh
}

