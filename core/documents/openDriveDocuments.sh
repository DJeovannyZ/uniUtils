function openDriveDocuments {
  local filesDrive=("$@") # obtiene los argumentos como un array
  for file in "${filesDrive[@]}"; do
    rclone lsjson gdrive:"$file" > tmp.json
    # Extraer el identificador del archivo del archivo temporal utilizando jq
    identificador=$(jq -r '.[0].ID' tmp.json)
    rm tmp.json
    extension="${file##*.}"
    if [[ "$extension" == "doc" || "$extension" == "docx" ]]; then
    brave "https://docs.google.com/document/u/2/d/$identificador/edit"
    filename=$(basename "$file")
    echo "Abriendo $filename en brave"
    elif [[ "$extension" == "xlsx"  ]]; then
    brave "https://docs.google.com/spreadsheets/u/2/d/$identificador/edit"
    filename=$(basename "$file")
    echo "Abriendo $filename en brave"
    fi
  done
}
