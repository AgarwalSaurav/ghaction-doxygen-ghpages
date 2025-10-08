#!/usr/bin/env bash

set -e
source /opt/venv/bin/activate

# $1 is the directory where doxygen should be executed
working_directory=$1
# $2 is the path to the Doxyfile relative to the working directory
doxyfile_path=$2
# $3 is the folder where html output should be generated
html_output_folder=$3

# Validate required parameters
if [ -z "${working_directory}" ]; then
  echo "Error: working_directory parameter is required!"
  exit 1
fi

if [ -z "${doxyfile_path}" ]; then
  echo "Error: doxyfile_path parameter is required!"
  exit 1
fi

if [ -z "${html_output_folder}" ]; then
  echo "Error: html_output_folder parameter is required!"
  exit 1
fi

# Validate working directory exists
if [ ! -d "${working_directory}" ]; then
  echo "Error: Path ${working_directory} could not be found!"
  exit 1
fi

cd "${working_directory}"

echo "==> Doxygen execution directory: ${working_directory}"
echo "==> Doxyfile path: ${doxyfile_path}"
echo "==> HTML output folder: ${html_output_folder}"

# Validate Doxyfile exists
if [ ! -f "${doxyfile_path}" ]; then
  echo "Error: File ${doxyfile_path} could not be found!"
  exit 1
fi

# Try to get git tag, use empty string if no tags exist
GIT_TAG=""
if git describe --tags --abbrev=0 &>/dev/null; then
  GIT_TAG=$(git describe --tags --abbrev=0)
  echo "==> Git tag found: ${GIT_TAG}"
else
  echo "==> Warning: No git tags found, continuing without version tag"
fi

# Run Doxygen with git tag if available
echo "==> Running Doxygen..."
if [ -n "${GIT_TAG}" ]; then
  GIT_TAG="${GIT_TAG}" doxygen "${doxyfile_path}"
else
  doxygen "${doxyfile_path}"
fi

echo "==> Doxygen generation completed successfully"

# Create .nojekyll file for GitHub Pages
if [ ! -d "${html_output_folder}" ]; then
  echo "Error: HTML output folder ${html_output_folder} was not created by Doxygen!"
  exit 1
fi

touch "${html_output_folder}"/.nojekyll
echo "==> Created .nojekyll file for GitHub Pages"
