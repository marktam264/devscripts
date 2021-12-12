#!/bin/bash

# this must be run at the top-level directory of the git repo
# this assumes that the current branch is master
#  will add user-provided branch name later

# do a git add all changes check and ask if agree
changes=$(git add -A -n)
while read line; do
  echo "$line"
done <<< "$changes"
if [ -n "$changes" ]; then
  read -p "Do you want to check these in? (Y/N) " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
  # if agree:
  #  add all changes
  echo "will check-in"
  git add -A
  #  ask for commit comment then commit changes
  read -p "Enter a comment: " comment
  echo "will commit with comment: ""$comment"
  git commit -m "$comment"
  #  push master to origin (or user provided local branch and remote repo)
  echo "will push to origin"
  git push -u origin master
  # else exit
else
  echo "Nothing to check in"
fi
