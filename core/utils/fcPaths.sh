#!/bin/bash


# Function to set default path
function setDefaultPath {
  
  # Check if all parameters are provided
  if [ "$#" -ne 1 ]; then
    echo "Error: to setDefaultPath expecify the path of workspace. use uniUtils --help for more information."
    return 1
  fi
  # Get the absolute path of the directory
  dir=$(readlink -f "$1")

  # Check if uniUtils directory exists
  if [ ! -d "$HOME/.config/uniUtils/" ]; then
    mkdir $HOME/.config/uniUtils/
  fi

  # Check if default path file exists
  if [ ! -f "$HOME/.config/uniUtils/default_path.txt" ]; then
    touch $HOME/.config/uniUtils/default_path.txt
  fi

  # Write default path to file
  echo "$dir" > $HOME/.config/uniUtils/default_path.txt
  echo "Default path set to: $dir"
}


# Function to check if default path file exists and create it if not
function checkDefaultPath {
  # Check if uniUtils directory exists
  if [ ! -d "$HOME/.config/uniUtils/" ]; then
    mkdir $HOME/.config/uniUtils/
  fi

  # Check if default path file exists
  if [ ! -f "$HOME/.config/uniUtils/default_path.txt" ]; then
    touch $HOME/.config/uniUtils/default_path.txt
  fi

  # Obtenemos la ruta del script "fcPaths.sh"
  script_path="$(realpath "${BASH_SOURCE[0]}")"
  script_dir="$(dirname "$script_path")"
  cd "$script_dir"
  cd ../../resources/
  
  # Chequeamos si existen los archivos y los copiamos si es necesario
  if [ ! -f "$HOME/.config/uniUtils/DocWord.docx" ]; then
      echo "Copiando archivo DocWord.docx"
      cp "DocWord.docx" "$HOME/.config/uniUtils/"
  fi
  
  if [ ! -f "$HOME/.config/uniUtils/DocExcel.xlsx" ]; then
      echo "Copiando archivo DocExcel.xlsx"
      cp "DocExcel.xlsx" "$HOME/.config/uniUtils/"
  fi

  if [ ! -f "$HOME/.config/uniUtils/DocPPT.pptx" ]; then
      echo "Copiando archivo DocPPT.pptx"
      cp "DocPPT.pptx" "$HOME/.config/uniUtils/"
  fi

  # Check if default path file has a path set
  if [ ! -s "$HOME/.config/uniUtils/default_path.txt" ]; then
    echo "Default path file is empty. Set default path using 'uniUtils --setDefaultPath <path>'"
  fi
}
