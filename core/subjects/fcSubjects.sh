#!/bin/bash

function registerSubject {
  read -p "Ingrese el nombre de la Asignatura: " nameSubject
  read -p "Ingrese el numero de Unidades de $nameSubject: " num
  read -p "Ingrese el numero de Semanas para cada Unidad de $nameSubject: " num2
  addSubject "$nameSubject"
  echo "Directorio para $nameSubject Creado"
  numUnits=$((num + 1))
  numWeeks=$((num2 + 1))
  for ((i = 1; i < numUnits; i++)); do
    unit="Unidad $i"
    addDirToSubject "$nameSubject" "$unit"
    echo "Directorio de la Unidad $i Creada para $nameSubject"
  done
  addDirToSubject "$nameSubject" "Generalidades $nameSubject"
  echo "Directorio Generalidades $nameSubject Creado"

  for ((i = 1; i < $numUnits; i++)); do
    unit="Unidad $i"
    for ((j = 1; j < $numWeeks; j++)); do
      week="Semana $j"
      addDirToUnit "$nameSubject" "$unit" "$week"
      echo "Directorio para la Semana $j de la Unidad $i creado en $nameSubject"
    done
    addDirToUnit "$nameSubject" "$unit" "Examenes"
    echo "Directorio de Examenes para la Unidad $i creado en $nameSubject"
    addDirToUnit "$nameSubject" "$unit" "Tareas"
    echo "Directorio de Tareas para la Unidad $i creado en $nameSubject"
    addDirToUnit "$nameSubject" "$unit" "Generalidades"
    echo "Directorio de Generalidades para la Unidad $i creado en $nameSubject"
  done
  echo "Asignatura "$nameSubject" Registrada en $defaultPath y en google Drive: Universidad/"
}

function addSubject {
  pathSubject="$defaultPath/$1"
  rcloneSubject="$rclonePath/$1"
  mkdir -p "$pathSubject"
  # rclone mkdir gdrive:"$rcloneSubject"
}

function addDirToSubject {
  nameSubject="$1"
  nameDir="$2"
  pathDirToSubject="$defaultPath/$nameSubject"
  pathDirRcloneToSubject="$rclonePath/$nameSubject"
  if [ -d "$pathDirToSubject" ]; then
    mkdir -p "$pathDirToSubject/$nameDir"
    # rclone mkdir gdrive:"$pathDirRcloneToSubject/$nameDir"
  else
    echo "La asignatura no existe"
  fi
}

function addDirToUnit {
  nameSubject="$1"
  nameUnit="$2"
  nameDir="$3"
  pathDirToUnit="$defaultPath/$nameSubject/$nameUnit"
  pathDirRcloneToUnit="$rclonePath/$nameSubject/$nameUnit"
  if [ -d "$pathDirToSubject" ]; then
    mkdir -p "$pathDirToUnit/$nameDir"
    # rclone mkdir gdrive:"$pathDirRcloneToUnit/$nameDir"
  else
    echo "La $nameUnit dentro de $nameSubject no existe"
  fi
}
