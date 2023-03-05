#!/bin/bash


function showHelp {
  echo -e "Uso: uniUtils [OPCIÓN]"
  echo -e ""
  echo -e "Opciones:"
  echo -e "  \033[1m--registerSubject    | -rs\033[0m           Registrar una nueva asignatura"
  echo -e "  \033[1m--openDocuments      | -od\033[0m           Abrir uno o varios documentos"
  echo -e "  \033[1m--pushFiles          | -phf\033[0m          Sincronizar carpeta local con Google Drive"
  echo -e "  \033[1m--pullFiles          | -plf\033[0m          Sincronizar Google Drive con carpeta local"
  echo -e "  \033[1m--updateFilesToDrive | -ufd\033[0m          Mandar nueva versión de archivos a Google Drive"
  echo -e "  \033[1m--updateFilesToLocal | -ufl\033[0m          Traer nueva versión de archivos de Google Drive"
  echo -e "  \033[1m--deleteFiles        | -df\033[0m           Eliminar documentos de local y Google Drive"
  echo -e "  \033[1m--goToDir            | -gd\033[0m           Ir a un directorio"
  echo -e "  \033[1m--addFiles           | -af\033[0m           Agregar documentos a una asignatura"
  echo -e "  \033[1m--createFiles        | -cf\033[0m           Crear documentos .docx .xlsx .pptx en una asignatura"
  echo -e "  \033[1m--setDefaultPath     | -s\033[0m            Establecer ruta por defecto donde se registraran las asignaturas"
  echo -e "  \033[1m--help               | -h\033[0m            Mostrar esta ayuda"
  echo -e ""
  echo -e "Ejemplos de uso:"
  echo -e "  uniUtils -rs"
  echo -e "  uniUtils --pullFiles"
  echo -e "  uniUtils -s /ruta/por/defecto"
}
