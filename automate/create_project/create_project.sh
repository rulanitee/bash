#!/bin/bash

# function to stop if there is an issue
die() { echo "$*" 1>&2; exit -1; }

# make sure that the name of the project is provided and git token is provided
if [ "$#" -ne 2 ]; then
  die "USAGE: create_project [name of the project] [git token]" >&2  
fi

# get the project name and git token
project_name=$1
token=$2

# got to the root 
cd 

# from the root, got to the personal folder for personal projects
cd ~/projects/personal/research/

# just in case there is a project with the same name
if [ -d "$project_name" ]; then
    die "Directory '$project_name' already exists"
fi

# creat directory for the project 
mkdir $project_name

# got to the project
cd $project_name

# create a read me file 
touch README.md

# json string to create repository
json_repository=$( jq  -n \
                        --arg repo "$project_name" \
                        '{
                            name:$repo, 
                            private:false
                         }' )

# create the repository using the github api
response=$( curl -H "Authorization: token $token" -H "Accept: application/json" -X POST https://api.github.com/user/repos -d "$json_repository" )
message=$( echo $response | jq -r '.["message"]' )

if [[ ! -z "$message" && "$message" != "null" ]]; then
    die "Error creating repository $project_name: $message"
fi

# init git
git init
# make first commit and push to the repo
git add README.md
git commit -m "first auto generated commit for my auto generated project: $project_name"
# make sure the local repo is linked with the upstream repo
git remote add origin git@github.com:rulanitee/$project_name.git
# push the first commit
git push -u origin master

# open VS code
code .