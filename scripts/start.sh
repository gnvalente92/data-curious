#!/bin/sh

if [[ $1 = "" ]]; then
  branch_name="feature/work-$(date +"%Y%m%d")"
  echo "Branch name not provided, using $branch_name."
else
  branch_name=$1
fi

if [[ $(git ls-remote --heads origin $branch_name) ]]; then
    echo "Branch already exists in remote repository, checking out its progress"
    git fetch
    git checkout $branch_name
else
    echo "Branch does not exist in remote repository, checking out a new local branch"
    git checkout -b $branch_name
fi

docker run --rm -p 8888:8888 -e JUPYTER_ENABLE_LAB=yes -v $(pwd)/work:/home/jovyan/ jupyter/datascience-notebook:latest
