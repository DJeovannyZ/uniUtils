#!/bin/bash
#
function pushFiles {
  dirDrive=$(echo "$defaultPath" | sed "s|$HOME/||")
  echo "Subiendo archivos de $defaultPath a Google Drive"
  rclone sync "$defaultPath" gdrive:"$dirDrive" -P
}

function pullFiles {
  dirDrive=$(echo "$defaultPath" | sed "s|$HOME/||")
  echo "Descargando archivos nuevos de Google Drive a $defaultPath"
  rclone sync gdrive:"$dirDrive" "$defaultPath" -P
}

function deleteFiles {
  selectFiles "$defaultPath"
  for file in "${selectedFiles[@]}"
  do
    fileName=$(basename "$file")
      fileDrive=$(echo "$file" | sed "s|$HOME/||")
      echo "Borrando $fileName de google drive"
      rclone delete gdrive:"$fileDrive" -P
      rm "$file"
      echo "Borrando $fileName de local"
  done
}
