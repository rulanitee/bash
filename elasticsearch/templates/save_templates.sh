#!/bin/bash

# The elasticsearch URL that is passed when executing the script
ELASTICSEARCH_URL=$1

# Gets the working directory of the scripts
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Loop through all the files within the directory
for entry in "$SCRIPT_DIR"/*
do
	# Get the file extensions
	extension="${entry##*.}"

	# Check if the file is json
	if [ $extension == "json" ] ; then
  		file_path="$entry"

  		# Get the file name without the extension
  		file_name=$(basename $file_path .$extension)  	

  		# Print the template that is going to be created
  		printf "creating template: $file_name \n"	

  		# Use template api to create the template using the json file
  		curl -XPUT "$ELASTICSEARCH_URL:9200/_template/$file_name" -d@$entry
  	fi
done