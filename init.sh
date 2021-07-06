#!/bin/sh

if [ $# != 1 ]; then
  echo "Please set an argument"
  return 2>&- || exit
fi


echo -n "React(Next.js)の環境構築を行いますか?[y/N]: "
read ANS

case $ANS in
  [Yy]* )
    echo -n "GraphQLの環境構築を行いますか?[y/N]: "
      read ANS2

      echo -n "CSSライブラリを選択してください"
      select VAR in tailwindcss Chakra-UI
      do
          if [ "$VAR" = "tailwindcss" ]; then
          yarn add twin.macro @emotion/{css,react,server,styled} ress
          yarn add -D babel-loader babel-plugin-{macros,twin} @emotion/{babel-plugin,babel-preset-css-prop} @babel/{core,plugin-transform-runtime,preset-env,preset-react}
          rm -f react/store_chakra.tsx
          rm -f react/store_chakra_graphql.tsx
          mv react/babel.config.js .
          mv react/tailwind.config.js .
          break
          fi
          if [ "$VAR" = "Chakra-UI" ]; then
          yarn add @chakra-ui/react @emotion/{css,react,styled,server} framer-motion@^4
          rm -f react/store_tailwind.tsx
          rm -f react/store_tailwind_graphql.tsx
          rm -rf react/babel.config.js
          rm -rf react/types/emotion.d.ts
          rm -rf react/types/twin.d.ts
          break
          fi
      done
    ;;
  * ) # React(Next.js)を使用しない場合
    rm -rf react
    rm -f package.json
    mv package.vanilla.json package.json
    ;;
esac

#rename this directory
initialDir=basename$(pwd)
initialDirVal=$(basename ${initialDir})
mv ../${initialDirVal} ../"$1"
cd ../"$1"

## allow env files
direnv allow

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

## set husky
npx husky install
npx husky-init

rm -f .husky/pre-commit
mv pre-commit .husky

case $ANS in
  [Yy]* ) #React(Next.js)を使う場合
    rm -f package.vanilla.json
    # add react deps
    yarn add react react-dom ress react-test-renderer @testing-library/react next
    # add react devdeps
    yarn add -D @types/{react,react-dom,react-test-renderer} \
    eslint-config-airbnb-typescript eslint-plugin-{jsx-a11y,react,react-hooks} \
    webpack eslint-config-next file-loader url-loader

    ## delete unuse files
    rm -f tsconfig.json esbuild.js .eslintrc.js
    rm -rf src
    ## move settings for react to current dir
    mv react/tsconfig.json .
    mv react/esbuild.js .
    mv react/.eslintrc.js .
    mkdir dist
    mv react/index.html dist
    mv react src

  # Next.js setup
    rm -f esbuild.js
    mv src/next.config.js .
    mv src/runtime.config.js .
    mv src/next-env.d.ts .
    mv src/pages src
    mv src/types src
    mv src/components src
    mv src/store_chakra.tsx src
    mv src/store_chakra_graphql.tsx src
    mv src/store_tailwind.tsx src
    mv src/store_tailwind_graphql.tsx src
    rm -rf dist
    rm -rf src/next
    rm -f src/index.tsx

    case $ANS2 in
      [Yy]* )
        # add graphql deps
        yarn add graphql @apollo/client
        yarn add -D @graphql-codegen/{cli,typescript,typescript-operations,typescript-react-apollo}

        rm -f runtime.config.js
        mv src/graphql/codegen.js .
        mv src/graphql/runtime.config.js .
        mv src/store_chakra_graphql.tsx src/store.tsx
        mv src/store_tailwind_graphql.tsx src/store.tsx
        rm -f src/store_chakra.tsx
        rm -f src/store_tailwind.tsx

        # add graphql endpoint
        echo "export GRAPHQL_ENDPOINT=http://localhost:3000/api/graphql
" >>.envrc
        npx npm-add-script -k codegen -v "graphql-codegen"
        ;;
      * ) # GraphQLを使わない場合
        rm -f codegen.js
        rm -rf src/graphql
        rm -f src/store_chakra_graphql.tsx
        rm -f src/store_tailwind_graphql.tsx
        mv src/store_chakra.tsx src/store.tsx
        mv src/store_tailwind.tsx src/store.tsx
        ;;
    esac
  ;;
esac


## remove this script
find ./ -name "init.sh" | xargs rm

## allow env files
direnv allow
