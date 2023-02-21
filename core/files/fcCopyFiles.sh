#!/bin/bash

function cpFiles {

  dirDrive=$(echo "$dirSelected" | sed "s|$HOME/||")
  for file in "$@"; do
    if [ -f "$file" ]; then
      # Obtiene la extensión del archivo
      ext="${file##*.}"

      nameFile=$(basename "$file")
      echo -e "  Copiando $nameFile a $dirSelected"
      cp "$file" "$dirSelected"

      # Verifica si la extensión es .xlsx, .doc o .docx
      if [ "$ext" = "xlsx" ] || [ "$ext" = "doc" ] || [ "$ext" = "docx" ]; then
        echo -e "  Subiendo $nameFile a  en $dirDrive"
        rclone copy "$file" "gdrive:$dirDrive"
      fi
    elif [ -d "$file" ]; then
      cp "$file" "$dirSelected"
      nameDir=$(basename "$file")
      echo -e "Copiando directorio $nameDir a $dirSelected"
    else
      echo "El archivo o directorio $file no existe o no se puede mover."
    fi
  done
}

