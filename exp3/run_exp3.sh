#!/bin/bash
set -e

echo "=== Experiment 3: Practice Source Code Management on GitHub (with Exercise 1 Code) ==="
rm -rf github_remote.git exp1_scm_repo

echo "1. Creating simulated remote GitHub repository (github_remote.git)"
git init --bare github_remote.git

echo "2. Cloning the repository to local machine: git clone ./github_remote.git exp1_scm_repo"
git clone ./github_remote.git exp1_scm_repo

echo "3. Moving to the repository directory: cd exp1_scm_repo"
cd exp1_scm_repo
git config user.name "DevOps Student"
git config user.email "student@smec.ac.in"

echo "4. Adding the source code written in Exercise 1"
cp -R ../../exp1/* .
rm -f flask.log
ls -la

echo "5. Staging the changes: git add ."
git add .
git status

echo "6. Committing the changes"
git commit -m "Added source code for a simple user registration form"

echo "7. Pushing changes to the remote repository: git push origin master"
git branch -M master
git push origin master

echo "8. Verifying changes in the remote repository"
git --git-dir=../github_remote.git log master --stat -n 1
