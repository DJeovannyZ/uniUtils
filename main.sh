#!/bin/bash

source ./core/dirs/fcSelectDir.sh 
source ./core/dirs/fcGoTodir.sh
source ./core/documents/fcOpenDocuments.sh
source ./core/documents/fcCreateDocuments.sh
source ./core/files/fcAddFiles.sh
source ./core/files/fcCopyFiles.sh
source ./core/files/fcSelectFiles.sh
source ./core/subjects/fcSubjects.sh
source ./core/utils/fcHelp.sh
source ./core/utils/fcPaths.sh

defaultPath=$(cat "$HOME/.config/uniUtils/default_path.txt")
rclonePath="Universidad"
selectedDir=
nameSelectedDir=
sameDir=
dirSelected=
selectedFiles=()

main() {
  # Call checkDefaultPath only if not called with setDefaultPath option
  if [ "$1" != "--setDefaultPath" ] && [ "$1" != "-s" ]; then
    checkDefaultPath
  fi
  clear
  # Check if no arguments are passed
  if [ $# -eq 0 ]; then
    echo "No arguments passed. Try 'uniUtils.sh --help' for more information."
  fi
    case "$1" in
      #Registrar una nueva asignatura
      --registerSubject | -rs)
        registerSubject
        ;;

      #Abri un Documento
      --openDocuments | -od)
        openDocuments
        ;;
        
      #Ir a un directorio
      --goToDir | -gd)
        goToDir
        ;;

      #Agregar documentos a una semana examenes o tareas
      --addFiles | -af)
        addFiles cpFiles "${@:2}"
        ;;

      --createFiles | -cf)
        addFiles createFiles
        ;;

      # Set default path
      --setDefaultPath | -s)
        setDefaultPath "$2"
        ;;

      # Show help
      --help | -h)
        showHelp
        exit 0
        ;;
# Invalid option
*)
echo "Invalid option. Try 'uniUtils --help' for more information."
exit 1
;;
esac
shift
}

main "$@"
