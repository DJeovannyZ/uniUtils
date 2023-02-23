#!/bin/bash
function createFiles {
    echo "Seleccione el tipo de archivo: "
    read -p "[1]Documento de Word [2]Hoja de calculo Excel: Default[1] " fileType
    read -p "Ingrese el nombre del archivo: " nameFile
    dirDrive=$(echo "$selectedDir" | sed "s|$HOME/||")
    declare -a docsDrive=() # declara un array vacío para almacenar los archivos con extensión .doc, .docx, .xlsx
    case "$fileType" in
        1) 
            cp "$HOME/.config/uniUtils/DocWord.docx" "$selectedDir"
            filePath="$selectedDir/$nameFile.docx"
            mv "$selectedDir/DocWord.docx" "$filePath"
            rclone copy "$filePath" "gdrive:$dirDrive"
            echo "Archivo $nameFile.docx creado"
            docsDrive+=("$dirDrive/$nameFile.docx")
            openDriveDocuments "${docsDrive[@]}"
        ;;
        2) 
            cp "$HOME/.config/uniUtils/DocExcel.xlsx" "$selectedDir"
            filePath="$selectedDir/$nameFile.xlsx"
            mv "$selectedDir/DocExcel.xlsx" "$filePath"
            rclone copy "$filePath" "gdrive:$dirDrive"
            echo "Archivo $nameFile.xlsx creado"
            docsDrive+=("$dirDrive/$nameFile.xlsx")
            openDriveDocuments "${docsDrive[@]}"
        ;;
        *) 
            cp "$HOME/.config/uniUtils/DocWord.docx" "$selectedDir"
            filePath="$selectedDir/$nameFile.docx"
            mv "$selectedDir/DocWord.docx" "$filePath"
            rclone copy "$filePath" "gdrive:$dirDrive"
            echo "Archivo $nameFile.docx creado"
            docsDrive+=("$dirDrive/$nameFile.docx")
            openDriveDocuments "${docsDrive[@]}"
        ;;
    esac

}

