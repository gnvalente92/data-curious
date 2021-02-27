#!/bin/sh

branch_name=$(git symbolic-ref -q HEAD)
branch_name=${branch_name##refs/heads/}
branch_name=${branch_name:-HEAD}

if [[ $1 = "" ]]; then
    echo "Commit message not provided."
    commit_message="Automated commit message"
else
    commit_message=$1
fi

echo "Saving progress on current branch ($branch_name) using commit message \"$commit_message\"."

git add .
git commit -m "$commit_message"
git push origin $branch_name
