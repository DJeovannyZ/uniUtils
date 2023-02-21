#!/bin/bash

function openDocuments {
  echo "Seleccione una Asignatura"
  selectDir "$defaultPath"
  dirSelected="$selectedDir"
  break_loop=false
  while [[ "$break_loop" == "false" ]]; do
    files=()
    dirs=()
    while IFS= read -r entry; do
      if [[ -d "$entry" ]]; then
        if [[ "$entry" != "$dirSelected" && "$entry" != "$dirSelected/." && "$entry" != "$dirSelected/.." ]]; then
          dirs+=("$entry")
        fi
      elif [[ -f "$entry" ]]; then
        files+=("$entry")
      fi
    done < <(find "$dirSelected" -maxdepth 1)
    if [[ ${#files[@]} -gt 0 && ${#dirs[@]} -eq 0 ]]; then
      selectFiles "$dirSelected"
      break_loop=true
    elif [[ ${#dirs[@]} -gt 0 && ${#files[@]} -eq 0 ]]; then
      selectDir "$dirSelected"
      dirSelected="$selectedDir"
    elif [[ ${#files[@]} -eq 0 && ${#dirs[@]} -eq 0 ]]; then
      echo "No hay archivos ni directorios en $dirSelected"
      break_loop=true
    else
      if [[ "$sameDir" == "false" ]]; then
        selectDir "$dirSelected" 1
        dirSelected="$selectedDir"
      else
        selectFiles "$dirSelected"
        break
      fi
    fi
  done

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
    if [[ "$extension" == "doc" || "$extension" == "docx" || "$extension" == "xlsx" ]]; then
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

function openDriveDocuments {
  local filesDrive=("$@") # obtiene los argumentos como un array
  for file in "${filesDrive[@]}"; do
    echo "$file"
    rclone lsjson gdrive:"$file" > tmp.json
    # Extraer el identificador del archivo del archivo temporal utilizando jq
    identificador=$(jq -r '.[0].ID' tmp.json)
    rm tmp.json
    brave "https://docs.google.com/spreadsheets/u/2/d/$identificador/edit"
  done
}

