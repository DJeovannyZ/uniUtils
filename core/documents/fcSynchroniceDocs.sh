#!/bin/bash
#
function pushFiles {
  selectFiles "$defaultPath"
  for file in "${selectedFiles[@]}"
  do
      fileName=$(basename "$file")
      fileDrive=$(echo "$file" | sed "s|$HOME/||")
      dirPathDrive=$(dirname "$fileDrive")
      echo "Borrando version antigua de $fileName de google drive"
      rclone delete gdrive:"$fileDrive" -P
      echo "Subiendo version actualizada de $fileName a google drive"
      rclone copy "$file" gdrive:"$dirPathDrive" -P
  done

}

function pullFiles {
  selectFiles "$defaultPath"
  for file in "${selectedFiles[@]}"
  do
      fileName=$(basename "$file")
      fileDrive=$(echo "$file" | sed "s|$HOME/||")
      dirFile=$(dirname "$file")
      rm "$file"
      echo "Borrando version antigua de $fileName de local"
      echo "Descargando version actualizada de $fileName de google drive"
      rclone copy gdrive:"$fileDrive" "$dirFile" -P
  done
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
