#!/bin/sh

echo -n "Next.jsの環境構築を行いますか?[y/N]: "
read ANS

case $ANS in
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


case $ANS in
  [Yy]* )
    # Next.js setup
    rm -f esbuild.js
    mv src/next/next.config.js .
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


## remove this script
find ./ -name "react.sh" | xargs rm
