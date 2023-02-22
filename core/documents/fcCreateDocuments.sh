#!/bin/bash
function createFiles {
    echo "Seleccione el tipo de archivo: "
    read -p "[1]Documento de Word [2]Hoja de calculo Excel: Default[1] " fileType
    read -p "Ingrese el nombre del archivo: " nameFile
    dirDrive=$(echo "$dirSelected" | sed "s|$HOME/||")
    case "$fileType" in
        1) 
            cp "$HOME/.config/uniUtils/DocWord.docx" "$dirSelected"
            filePath="$dirSelected/$nameFile.docx"
            mv "$dirSelected/DocWord.docx" "$filePath"
            rclone copy "$filePath" "gdrive:$dirDrive"
        ;;
        2) 
            cp "$HOME/.config/uniUtils/DocExcel.xlsx" "$dirSelected"
            filePath="$dirSelected/$nameFile.xlsx"
            mv "$dirSelected/DocExcel.xlsx" "$filePath"
            rclone copy "$filePath" "gdrive:$dirDrive"
        ;;
        *) 
            cp "$HOME/.config/uniUtils/DocWord.docx" "$dirSelected"
            filePath="$dirSelected/$nameFile.docx"
            mv "$dirSelected/DocWord.docx" "$filePath"
            rclone copy "$filePath" "gdrive:$dirDrive"
        ;;
    esac

}

