#!/bin/bash

function selectFiles {
  local path="$1"
  local files=("$path"/*)
  local numFiles=0

  for file in "${files[@]}"; do
    if [[ -f "$file" ]]; then
      ((numFiles++))
      echo "$numFiles - ${file##*/}"
    fi
  done
  if ((numFiles == 0)); then
    echo "No hay archivos en $path"
    return 1
  else
    while true; do
      read -p "Seleccione uno o más archivos (separe los números con espacios): " fileNums
      local invalidOption=false
      
      for num in $fileNums; do
        if ((num >= 1 && num <= numFiles)); then
          local count=0
          for file in "${files[@]}"; do
            if [[ -f "$file" ]]; then
              ((count++))
              if ((count == num)); then
                selectedFiles+=("$file")
                break
              fi
            fi
          done
        else
          invalidOption=true
          break
        fi
      done
      
      if "$invalidOption"; then
        echo "Opción inválida. Introduzca números entre 1 y $numFiles."
      elif [[ "${#selectedFiles[@]}" == 0 ]]; then
        echo "No se seleccionaron archivos."
      else
        # echo "Archivos seleccionados: "
        # for file in "${selectedFiles[@]}"; do
        #   echo "- ${file##*/}"
        # done
        break
      fi
    done
  fi
}

