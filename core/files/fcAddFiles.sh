#!/bin/bash

function addFiles {
  if [ $# -lt 1 ]; then  # Verificar que hay al menos un argumento 
    echo "La función addFiles requiere al menos un argumento."
    return 1
  fi

  echo "Seleccione una Asignatura"
  selectDir "$defaultPath"
  dirSelected="$selectedDir"
  sameDir=false
  break_loop=false

  # Obtener la función que se va a llamar
  func="$1"
  shift

  while [[ "$break_loop" == "false" ]]; do
    # Verificar si hay directorios en $dirSelected
    if [[ $(find "$dirSelected" -mindepth 1 -type d | wc -l) -eq 0 ]]; then
      # Llamar a la función correspondiente
      case "$func" in
        cpFiles) cpFiles "$@" ;;
        createFiles) createFiles ;;
      esac
      break
    fi
    if [[ "$sameDir" == "false" ]]; then
      selectDir "$dirSelected" 1
      dirSelected="$selectedDir"
    else
      # Llamar a la función correspondiente
      case "$func" in
        cpFiles) cpFiles "$@" ;;
        createFiles) createFiles ;;
      esac
      break
    fi
  done
}

