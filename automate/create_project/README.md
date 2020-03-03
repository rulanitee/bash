# Create Project

This is just a bash script i use to create project for me by:

*   Creating a folder with the name of the project
*   Creating a README.md file
*   Creating a git repository with the same name as the project
*   Making the first commit to the git
*   Open IDE, VS

## Dependencies

*   For the script to work, make sure you have a github personal access token. This is for authenticating when creating the repository.
*   Make sure jq is installed. This is to get the message from the JSON response from git api.

It is just a way of automating the process of creating my projects. Lastly, you can make the executable global by making a symlink to /usr/bin directory.