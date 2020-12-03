#!/bin/sh

if [ $# != 1 ]; then
  echo "Please set an argument"
  return 2>&- || exit
fi

#rename this directory
initialDir=basename$(pwd)
initialDirVal=$(basename ${initialDir})
mv ../${initialDirVal} ../"$1"
cd ../"$1"

## setting git
rm -rf .git
rm -f .gitignore README.md
touch .gitignore .env
echo 'node_modules
dist/*
yarn-error.log
.DS_Store
.vscode
.env
src/types/graphql.ts
' >>.gitignore
git init &


yarn add -D typescript webpack webpack-cli eslint jest prettier \
  ts-jest ts-loader \
  eslint-{config-prettier,plugin-import,plugin-jest,plugin-prettier} \
  @types/jest @types/node @typescript-eslint/eslint-plugin @typescript-eslint/parser \
  lint-staged husky

## write README
touch README.md
echo "# $1" >>README.md

## setup test folder
mkdir src/__tests__

## remove this script
find ./ -name "init.sh" | xargs rm
