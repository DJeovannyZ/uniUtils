#!/bin/bash
function createFiles {
    selectDir
    echo "Seleccione el tipo de archivo: "
    read -p "[1]Documento de Word [2]Hoja de calculo Excel [3]Presentacion | Default[1]: " fileType
    read -p "Ingrese el nombre del archivo: " nameFile
    dirDrive=$(echo "$selectedDir" | sed "s|$HOME/||")
    declare -a docsDrive=() # declara un array vacío para almacenar los archivos con extensión .doc, .docx, .xlsx
    case "$fileType" in
        1) 
            dirSubject="$(echo "$selectedDir" | sed -E 's/^(.*Ciclo 3\/[^/]+)\/.*/\1/')"
            nameSubject="$(basename "$dirSubject")"
            portadaPath="$dirSubject/Generalidades $nameSubject/Portada.docx"
            cp "$portadaPath" "$selectedDir"
            filePath="$selectedDir/$nameFile.docx"
            mv "$selectedDir/Portada.docx" "$filePath"
            echo " Subiendo $filePath a google drive"
            rclone copy "$filePath" "gdrive:$dirDrive" -P
            docsDrive+=("$dirDrive/$nameFile.docx")
            openDriveDocuments "${docsDrive[@]}"
        ;;
        2) 
            cp "$HOME/.config/uniUtils/DocExcel.xlsx" "$selectedDir"
            filePath="$selectedDir/$nameFile.xlsx"
            mv "$selectedDir/DocExcel.xlsx" "$filePath"
            echo " Subiendo $filePath a google drive"
            rclone copy "$filePath" "gdrive:$dirDrive" -P
            docsDrive+=("$dirDrive/$nameFile.xlsx")
            openDriveDocuments "${docsDrive[@]}"
        ;;
        3) 
            cp "$HOME/.config/uniUtils/DocPPT.pptx" "$selectedDir"
            filePath="$selectedDir/$nameFile.pptx"
            mv "$selectedDir/DocPPT.pptx" "$filePath"
            echo " Subiendo $filePath a google drive"
            rclone copy "$filePath" "gdrive:$dirDrive" -P
            docsDrive+=("$dirDrive/$nameFile.pptx")
            openDriveDocuments "${docsDrive[@]}"
        ;;
        *) 
            dirSubject="$(echo "$selectedDir" | sed -E 's/^(.*Ciclo 3\/[^/]+)\/.*/\1/')"
            nameSubject="$(basename "$dirSubject")"
            portadaPath="$dirSubject/Generalidades $nameSubject/Portada.docx"
            cp "$portadaPath" "$selectedDir"
            filePath="$selectedDir/$nameFile.docx"
            mv "$selectedDir/Portada.docx" "$filePath"
            echo " Subiendo $filePath a google drive"
            rclone copy "$filePath" "gdrive:$dirDrive" -P
            docsDrive+=("$dirDrive/$nameFile.docx")
            openDriveDocuments "${docsDrive[@]}"
        ;;
    esac

}

