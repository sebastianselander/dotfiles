    if [ -d "/path/to/dir" ] && [ -n "$(ls -A "/path/to/dir")" ] then
        NAME=basename "$PWD"

        git init
        git add .
        git commit -m "Initial commit"
        gh repo create $NAME --private --push --source .
    else
        echo "Folder is empty"
    fi
