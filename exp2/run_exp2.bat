@echo off
setlocal
cd /d "%~dp0"

echo === Experiment 2: Explore Git and GitHub Commands ===
if exist "repo_demo" rmdir /s /q "repo_demo"
if exist "remote_origin.git" rmdir /s /q "remote_origin.git"
if exist "cloned_repo" rmdir /s /q "cloned_repo"

mkdir repo_demo
git init --bare remote_origin.git

cd repo_demo
echo 1. Initializing a Git repository: git init
git init
git config user.name "DevOps Student"
git config user.email "student@smec.ac.in"

echo 2. Checking the status of repository: git status
git status

echo 3. Creating a sample file and adding to stage: git add sample.txt
echo Initial version of DevOps Lab file> sample.txt
git add sample.txt
git status

echo 4. Committing changes: git commit -m "Initial commit"
git commit -m "Initial commit"

echo 5. Checking commit history: git log
git log --oneline

echo 6. Modifying file and undoing changes: git checkout sample.txt
echo Unwanted modification>> sample.txt
git status -s
git checkout sample.txt
type sample.txt

echo 7. Creating a new branch: git branch feature-branch
git branch feature-branch

echo 8. Switching to a different branch: git checkout feature-branch
git checkout feature-branch
echo Feature branch update>> sample.txt
git add sample.txt
git commit -m "Add feature update"

echo 9. Switching back and merging two branches: git merge feature-branch
git checkout main 2>nul || git checkout master 2>nul
for /f "delims=" %%b in ('git rev-parse --abbrev-ref HEAD') do set CURRENT_BRANCH=%%b
git merge feature-branch

echo 10. Pushing changes to remote repository: git push origin %CURRENT_BRANCH%
git remote add origin ../remote_origin.git
git push origin %CURRENT_BRANCH%

cd ..
echo 11. Cloning a repository: git clone ./remote_origin.git cloned_repo
git clone ./remote_origin.git cloned_repo
dir cloned_repo
