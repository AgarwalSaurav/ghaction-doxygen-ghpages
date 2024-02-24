#!/bin/sh -l

# $1 Mount point for the repository
repository_mount_point=$1
# $2 is the directory where doxygen should be executed
working_directory=$2
# $3 is the path to the Doxyfile relative to the working directory
doxyfile_path=$3
# $4 is the folder where html output should be generated
html_output_folder=$4

cd ${repository_mount_point}

if [ ! -d ${working_directory} ]; then
  echo "Path ${working_directory} could not be found!"
  exit 1
fi
cd $2

if [ ! -f ${doxyfile_path} ]; then
  echo "File ${doxyfile_path} could not be found!"
  exit 1
fi

doxygen ${doxyfile_path}

touch ${html_output_folder}/.nojekyll
