#!/bin/bash

function cpFiles {
    echo "Seleccione los archivos usando espacio y luego Enter"
    sleep 1
    path=$(pwd)
    selectFiles $path
    echo "Seleccione el directorio de destino"
    sleep 1
    selectDir

  dirDrive=$(echo "$selectedDir" | sed "s|$HOME/||")

  for file in "${selectedFiles[@]}"
  do
    if [ -f "$file" ]; then
      # Obtiene la extensión del archivo
      ext="${file##*.}"

      nameFile=$(basename "$file")
      echo -e "  Copiando $nameFile a $selectedDir"
      cp "$file" "$selectedDir"

      # Verifica si la extensión es .xlsx, .doc o .docx
      if [ "$ext" = "xlsx" ] || [ "$ext" = "doc" ] || [ "$ext" = "docx" ]; then
        echo -e "  Subiendo $nameFile a  en $dirDrive"
        rclone copy "$file" "gdrive:$dirDrive"
      fi
    elif [ -d "$file" ]; then
      cp "$file" "$selectedDir"
      nameDir=$(basename "$file")
      echo -e "Copiando directorio $nameDir a $selectedDir"
    else
      echo "El archivo o directorio $file no existe o no se puede mover."
    fi
  done
}

