#!/bin/bash

function cpFiles {

    selectFiles "$HOME/Downloads"
  if ! [ -z "${selectedFiles[@]}" ]; then
    selectDir
    dirDrive=$(echo "$selectedDir" | sed "s|$HOME/||")

    for file in "${selectedFiles[@]}"
    do
      if [ -f "$file" ]; then
        # Obtiene la extensión del archivo
        ext="${file##*.}"

        nameFile=$(basename "$file")
        nameFileNoExtension="${nameFile%.*}"

        if [ "$ext" = "pptx" ]; then
            if [ $# -eq 0 ] ; then
              echo "convirtiendo $file a  pdf"
              libreoffice --convert-to pdf --outdir "$selectedDir" "$file" 
              rm -r "$file"
              echo -e " Subiendo $selectedDir/$nameFileNoExtension.pdf a  en $dirDrive"
              rclone copy "$selectedDir/$nameFileNoExtension.pdf" "gdrive:$dirDrive" -P
              continue
            elif [ "$1" = "--no-convert" ] ; then
              echo "Omitiendo conversion de $file a pdf"
            fi
        fi
          echo -e "  Subiendo $nameFile a  en $dirDrive"
          rclone copy "$file" "gdrive:$dirDrive" -P
        echo -e "  Moviendo $nameFile a $selectedDir"
        mv "$file" "$selectedDir"
      elif [ -d "$file" ]; then
        mv "$file" "$selectedDir"
        nameDir=$(basename "$file")
        echo -e "Moviendo directorio $nameDir a $selectedDir"
      else
        echo "El archivo o directorio $file no existe o no se puede mover."
      fi
    done
  else
    echo "Debe seleccionar al menos un archivo"
  fi
}

