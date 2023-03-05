#!/usr/bin/bash

function openDriveDocuments {
  local filesDrive=("$@") # obtiene los argumentos como un array
  for file in "${filesDrive[@]}"; do
    filename=$(basename "$file")
    echo "Abriendo $file en brave"
    rclone lsjson gdrive:"$file" > tmp.json
    # Extraer el identificador del archivo del archivo temporal utilizando jq
    identificador=$(jq -r '.[0].ID' tmp.json)
    rm tmp.json
    extension="${file##*.}"
    if [[ "$extension" == "doc" || "$extension" == "docx" ]]; then
    brave "https://docs.google.com/document/u/2/d/$identificador/edit"
    elif [[ "$extension" == "xlsx"  ]]; then
    brave "https://docs.google.com/spreadsheets/u/2/d/$identificador/edit"
    elif [[ "$extension" == "pptx"  ]]; then
    brave "https://docs.google.com/presentation/u/2/d/$identificador/edit"
    fi
  done
}
