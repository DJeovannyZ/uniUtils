#!/bin/bash
#
function pushFiles {
  selectFiles "$defaultPath"
  for file in "${selectedFiles[@]}"
  do
    extension="${file##*.}"
    if [[ "$extension" == "doc" || "$extension" == "docx" || "$extension" == "xlsx" ]]; then
      fileName=$(basename "$file")
      fileDrive=$(echo "$file" | sed "s|$HOME/||")
      dirPathDrive=$(dirname "$fileDrive")
      echo "Borrando version antigua de $fileName de google drive"
      rclone delete gdrive:"$fileDrive"
      echo "Subiendo version actualizada de $fileName a google drive"
      rclone copy "$file" gdrive:"$dirPathDrive"
    fi
  done

}

function pullFiles {
  selectFiles "$defaultPath"
  for file in "${selectedFiles[@]}"
  do
    extension="${file##*.}"
    if [[ "$extension" == "doc" || "$extension" == "docx" || "$extension" == "xlsx" ]]; then
      fileName=$(basename "$file")
      fileDrive=$(echo "$file" | sed "s|$HOME/||")
      dirFile=$(dirname "$file")
      rm "$file"
      echo "Borrando version antigua de $fileName de local"
      echo "Descargando version actualizada de $fileName de google drive"
      rclone copy gdrive:"$fileDrive" "$dirFile"
    fi
  done
}

function deleteFiles {
  selectFiles "$defaultPath"
  for file in "${selectedFiles[@]}"
  do
    extension="${file##*.}"
    fileName=$(basename "$file")
    if [[ "$extension" == "doc" || "$extension" == "docx" || "$extension" == "xlsx" ]]; then
      fileDrive=$(echo "$file" | sed "s|$HOME/||")
      echo "Borrando $fileName de google drive"
      rclone delete gdrive:"$fileDrive"
      rm "$file"
      echo "Borrando $fileName de local"
    else
        rm "$file"
        echo "Borrando $fileName de local"
    fi
  done

}
