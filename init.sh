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
touch .gitignore
echo 'node_modules
dist/*
yarn-error.log
.DS_Store
.vscode
.envrc
src/types/graphql.ts
' >>.gitignore
git init &


yarn add -D typescript esbuild eslint jest prettier \
  ts-jest glob \
  eslint-{config-prettier,plugin-import,plugin-jest,plugin-prettier} \
  @types/{node,jest} @typescript-eslint/eslint-plugin @typescript-eslint/parser husky

## write README
touch README.md
echo "# $1" >>README.md

## setup test folder
mkdir src/__tests__

## allow env files
direnv allow

## set husky
npx husky install
npx husky-init

rm -f .husky/pre-commit
mv pre-commit .husky



echo -n "Reactの環境構築を行いますか?[y/N]: "
read ANS

case $ANS in
  [Yy]* )
    # ここに「Yes」の時の処理を書く
    source ./react/react.sh
    ;;
  * )
    # ここに「No」の時の処理を書く
    rm -rf react
    ;;
esac


## remove this script
find ./ -name "init.sh" | xargs rm
