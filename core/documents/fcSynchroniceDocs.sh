#!/bin/bash
#
function pushFiles {
  dirDrive=$(echo "$defaultPath" | sed "s|$HOME/||")
  echo " Subiendo archivos de $defaultPath a Google Drive"
  rclone sync "$defaultPath" gdrive:"$dirDrive" --create-empty-src-dirs -P
}

function pullFiles {
  dirDrive=$(echo "$defaultPath" | sed "s|$HOME/||")
  echo " Descargando archivos nuevos de Google Drive a $defaultPath"
  rclone sync gdrive:"$dirDrive" "$defaultPath" --create-empty-src-dirs -P
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
      echo " Borrando $fileName de local"
  done
}

function updateFilesToDrive {
  selectFiles "$defaultPath"
  for file in "${selectedFiles[@]}"
  do
      fileName=$(basename "$file")
      fileDrive=$(echo "$file" | sed "s|$HOME/||")
      dirPathDrive=$(dirname "$fileDrive")
      echo " Borrando version antigua de $fileName de google drive"
      rclone delete gdrive:"$fileDrive" -P
      echo " Subiendo version actualizada de $fileName a google drive"
      rclone copy "$file" gdrive:"$dirPathDrive" -P
  done

}

function updateFilesToLocal {
  selectFiles "$defaultPath"
  for file in "${selectedFiles[@]}"
  do
      fileName=$(basename "$file")
      fileDrive=$(echo "$file" | sed "s|$HOME/||")
      dirFile=$(dirname "$file")
      rm "$file"
      echo " Borrando version antigua de $fileName de local"
      echo " Descargando version actualizada de $fileName de google drive"
      rclone copy gdrive:"$fileDrive" "$dirFile" -P
  done
}
