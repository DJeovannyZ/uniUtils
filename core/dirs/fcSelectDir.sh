#!/bin/bash

function selectDir {
  local path="$1"
  local dirs=("$path"/*)
  local numDirs=0

  if [ $# -eq 2 ]; then
    echo "$numDirs - 󱧰 ${selectedDir##*/}"
    for dir in "${dirs[@]}"; do
      if [[ -d "$dir" ]] && [[ ! "$dir" =~ \.\.?$ ]]; then
        ((numDirs++))
        echo "     󱞪 $numDirs - 󰉋 ${dir##*/}"
      fi
    done
  else
    for dir in "${dirs[@]}"; do
      if [[ -d "$dir" ]] && [[ ! "$dir" =~ \.\.?$ ]]; then
        ((numDirs++))
        echo "$numDirs - ${dir##*/}"
      fi
    done
  fi

  if ((numDirs == 0)); then
    echo "No hay directorios en $path"
    return 1
  else
    while true; do
      read -p "Seleccione un directorio (0-$numDirs): " dirNum
      if ((dirNum >= 0 && dirNum <= numDirs)); then
        if ((dirNum == 0)) && [ $# -eq 2 ]; then
          selectedDir="$selectedDir"
          nameSelectedDir=$(basename "$selectedDir")
          sameDir=true
          break
        elif ((dirNum != 0)); then
          local count=0
          for dir in "${dirs[@]}"; do
            if [[ -d "$dir" ]]; then
              ((count++))
              if ((count == dirNum)); then
                selectedDir="$dir"
                sameDir=false
                break
              fi
            fi
          done
          if [[ -d "$selectedDir" ]]; then
            nameSelectedDir=$(basename "$selectedDir")
            break
          else
            echo "La opción seleccionada no es un directorio válido."
          fi
        fi
      else
        echo "Opción inválida. Introduzca un número entre 0 y $numDirs."
      fi
    done
  fi
}


