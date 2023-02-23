#!/bin/bash

function addFiles {
  if [ $# -lt 1 ]; then  # Verificar que hay al menos un argumento 
    echo "La función addFiles requiere al menos un argumento."
    return 1
  fi

  selectDir

  # Obtener la función que se va a llamar
  func="$1"
  shift

  case "$func" in
    cpFiles) cpFiles "$@" ;;
    createFiles) createFiles ;;
  esac
}

