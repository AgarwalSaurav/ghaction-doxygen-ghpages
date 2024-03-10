#!/bin/sh -l

set -e
source /opt/venv/bin/activate
# $1 is the directory where doxygen should be executed
working_directory=$1
# $2 is the path to the Doxyfile relative to the working directory
doxyfile_path=$2
# $3 is the folder where html output should be generated
html_output_folder=$3

if [ ! -d ${working_directory} ]; then
  echo "Path ${working_directory} could not be found!"
  exit 1
fi
cd ${working_directory}

echo "Doxygen will be executed in the following directory: ${working_directory}"
echo "Doxyfile path: ${doxyfile_path}"

if [ ! -f ${doxyfile_path} ]; then
  echo "File ${doxyfile_path} could not be found!"
  exit 1
fi

GIT_TAG=$(git describe --tags --abbrev=0) doxygen ${doxyfile_path} > /dev/null

touch ${html_output_folder}/.nojekyll
