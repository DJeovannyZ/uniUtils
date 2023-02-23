#!/bin/bash

function showhelp {
  echo "Uso: uniUtils [opción] [argumentos]"
  echo ""
  echo "Descripción:"
  echo "Este script tiene como objetivo facilitar la gestión de archivos para estudiantes universitarios."
  echo ""
  echo "Opciones:"
  echo " registerSubject                Registra una nueva asignatura y crea los directorios para sus unidades y semanas."
  echo " addFiles                       Mueve documentos a un directorio."
  echo " openDocuments                  Abre los documentos de un directorio."
  echo " createFiles                    Crea un nuevo archivo de Word o Excel y lo copia en la nube de Google Drive."
  echo ""
  echo "Argumentos:"
  echo " El comando registerSubject no requiere argumentos adicionales."
  echo " Para el comando addFiles, se deben proporcionar los archivos o directorios a mover, separados por un espacio."
  echo " Para el comando openDocuments, se deben seleccionar la carpeta y los archivos a abrir."
  echo " Para el comando createFiles, se deben proporcionar los siguientes argumentos:"
  echo "    fileType                      El tipo de archivo a crear: 1 para Documento de Word, 2 para Hoja de cálculo de Excel."
  echo "                                  Si no se proporciona este argumento, se creará un nuevo Documento de Word por defecto."
  echo "    nameFile                      El nombre del archivo a crear."
  echo "                                  Si no se proporciona este argumento, se utilizará el nombre \"Untitled\" por defecto."
}
