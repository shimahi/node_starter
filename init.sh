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

      case $ANS2 in
        [Yy]* )
            echo -n "GraphQLの環境構築を行いますか?[y/N]: "
            read ANS3

            echo -n "CSSライブラリを選択してください"
            select VAR in tailwindcss Chakra-UI
            do
                if [ "$VAR" = "tailwindcss" ]; then
                yarn add twin.macro @emotion/{css,react,server,styled} ress
                yarn add -D babel-loader babel-plugin-{macros,twin} @emotion/{babel-plugin,babel-preset-css-prop} @babel/{core,plugin-transform-runtime,preset-env,preset-react}
                rm -f react/next/store_chakra.tsx
                rm -f react/next/store_chakra_graphql.tsx
                mv react/next/babel.config.js .
                mv react/next/tailwind.config.js .
                break
                fi
                if [ "$VAR" = "Chakra-UI" ]; then
                yarn add @chakra-ui/react @emotion/{react,styled} framer-motion@^4
                rm -f react/next/store_tailwind.tsx
                rm -f react/next/store_tailwind_graphql.tsx
                rm -rf react/next/babel.config.js
                rm -rf react/next/types/emotion.d.ts
                rm -rf react/next/types/twin.d.ts
                break
                fi
            done
          ;;
        * ) #Next.jsを使用しない場合
            rm -rf react/next
            rm -rf react/graphql
            rm -f package.json
            mv package.vanilla.json package.json
          ;;
      esac
    ;;
  * ) # Reactを使用しない場合
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
  [Yy]* )
    case $ANS2 in
      [Yy]* )
        rm -f package.vanilla.json
        # add Next.js deps
        yarn add next
        # add Next.js devdeps
        yarn add -D webpack eslint-config-next file-loader url-loader
        ;;
    esac
    # add react deps
    yarn add react react-dom ress react-test-renderer @testing-library/react
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
        mv src/next/types src
        mv src/next/components src
        mv src/next/store_chakra.tsx src
        mv src/next/store_chakra_graphql.tsx src
        mv src/next/store_tailwind.tsx src
        mv src/next/store_tailwind_graphql.tsx src
        rm -rf dist
        rm -rf src/next
        rm -f src/index.tsx

        cat tsconfig.json | jq '.include = ["src", "next-env.d.ts"]' > temp.json
        rm -f tsconfig.json
        mv temp.json tsconfig.json
        case $ANS3 in
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
    ;;
esac


## remove this script
find ./ -name "init.sh" | xargs rm

## allow env files
direnv allow
