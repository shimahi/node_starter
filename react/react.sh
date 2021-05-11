#!/bin/sh

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
mv react/babel.config.js .
mv react/codegen.js .
mkdir dist
mv react/index.html dist
mv react src


## remove this script
find ./ -name "react.sh" | xargs rm
