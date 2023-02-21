#!/bin/bash

function goToDir {
  echo "Seleccione una Asignatura"
  selectDir "$defaultPath"
  dirSelected="$selectedDir"
  break_loop=false
  while [[ "$break_loop" == "false" ]]; do
      echo "Seleccione una opción:"

      read -p "[1] Buscar otro directorio [2] ir a $dirSelected | default[1]: " option
      case $option in
      1)
        selectDir "$dirSelected"
        dirSelected="$selectedDir"
        ;;
      2)
        cd "$dirSelected"
        exec zsh
        break_loop=true
        break
        ;;
      *)
        selectDir "$dirSelected"
        dirSelected="$selectedDir"
        ;;
    esac
  done
}

