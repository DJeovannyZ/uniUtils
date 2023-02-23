#!/bin/bash

function selectDir {
    ranger  $defaultPath --choosedir=outdir --show-only-dirs
    selectedDir=$(cat outdir)
    rm outdir
}

