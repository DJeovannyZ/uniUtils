#!/bin/bash

function openDocuments {
  selectFiles "$defaultPath"
  declare -A apps=(
    ["pdf"]="brave"
    ["pptx"]="brave"
    ["mkv"]="vlc"
    ["mp4"]="vlc"
    ["jpg"]="mirage"
    ["png"]="mirage"
    ["jpeg"]="mirage"
  ) 
   
  declare -A file_lists
   
  declare -a docsDrive=() # declara un array vacío para almacenar los archivos con extensión .doc, .docx, .xlsx

  for file in "${selectedFiles[@]}"
  do
    extension="${file##*.}"
    if [[ "$extension" == "doc" || "$extension" == "docx" || "$extension" == "xlsx" || "$extension" == "pptx" ]]; then
      fileDrive=$(echo "$file" | sed "s|$HOME/||")
      docsDrive+=("$fileDrive") # agrega el archivo al array de archivos .doc, .docx, .xlsx
    elif [[ -n "${apps[$extension]}" ]]; then
      file_lists[$extension]+="\"$file\"\n"
    else
      echo "No hay aplicación predeterminada para el archivo $file"
    fi
  done
   
  for extension in "${!file_lists[@]}"
  do
    files="${file_lists[$extension]}"
    if [[ -n "$files" ]]; then
      echo -e "$files" | xargs -n 1 "${apps[$extension]}" &
    fi
  done
  if [ ${#docsDrive[@]} -gt 0 ]; then
    openDriveDocuments "${docsDrive[@]}"
  fi
}
