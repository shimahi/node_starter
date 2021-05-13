#!/bin/sh

if [ $# != 1 ]; then
  echo "Please set an argument"
  return 2>&- || exit
fi


echo -n "Reactの環境構築を行いますか?[y/N]: "
read ANS

case $ANS in
  [Yy]* )
      echo -n "Next.jsの環境構築を行いますか?[y/N]: "
      read ANS2
    ;;
  * )
    rm -rf react
    ;;
esac

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
.next
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

case $ANS in
  [Yy]* )
    case $ANS2 in
      [Yy]* )
        # add Next.js deps
        yarn add next graphql @apollo/client
        # add Next.js devdeps
        yarn add -D webpack esbuild-loader

        # add graphql endpoint
        echo "GRAPHQL_ENDPOINT=http://localhost:3000/api/graphql
        " >>.env.local
        ;;
      * )
        rm -rf react/next
        ;;
    esac
    # add react deps
    yarn add react react-dom ress @chakra-ui/react @emotion/react@^11 @emotion/styled@^11 framer-motion@^4 react-test-renderer @testing-library/react
    # add react devdeps
    yarn add -D @types/{react,react-dom,react-test-renderer} \
    eslint-config-airbnb-typescript eslint-plugin-{jsx-a11y,react,react-hooks} \
    ## delete unuse files
    rm -f tsconfig.json esbuild.js .eslintrc.js
    rm -rf src
    ## move settings for react to current dir
    mv react/tsconfig.json .
    mv react/esbuild.js .
    mv react/.eslintrc.js .
    mv react/codegen.js .
    mkdir dist
    mv react/index.html dist
    mv react src
    case $ANS2 in
      [Yy]* )
        # Next.js setup
        rm -f esbuild.js
        mv src/next/next.config.js .
        mv src/next/runtime.config.js .
        mv src/next/next-env.d.ts .
        mv src/next/pages src
        mv src/next/components src
        rm -rf dist
        rm -rf next
        rm src/index.tsx

        npx npm-add-script -k dev -v "next dev"
        npx npm-add-script -k start -v "next start"
        npx npm-add-script -k export -v "next export"

        cat tsconfig.json | jq '.include = ["src", "next-env.d.ts"]' > temp.json
        rm -f tsconfig.json
        mv temp.json tsconfig.json
        ;;
      * )
        ;;
    esac

    ;;
  * )
    ;;
esac


## remove this script
find ./ -name "init.sh" | xargs rm
