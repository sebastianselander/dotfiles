Script for easily creating a repository locally as well as on github simultaneously
```bash
if [ "$(ls -A .)" ]; then
    NAME=basename "$PWD"
    git init
    git add .
    git commit -m "Initial commit"
    gh repo create $NAME --private --push --source .
else
    echo "Folder is empty"
fi
```
