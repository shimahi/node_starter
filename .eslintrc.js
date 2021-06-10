module.exports = {
  parser: '@typescript-eslint/parser',
  env: {
    browser: true,
    es6: true,
    jest: true,
  },
  extends: ['airbnb-typescript', 'plugin:@typescript-eslint/recommended', 'plugin:react/recommended', 'prettier'],
  parserOptions: {
    project: './tsconfig.json',
    ecmaVersion: 2018,
    sourceType: 'module',
    ecmaFeatures: {
      jsx: true,
    },
  },
  plugins: ['@typescript-eslint', 'import', 'jsx-a11y', 'prettier', 'react', 'react-hooks'],
  rules: {
    // eslint
    'global-require': 'off',
    'consistent-return': 'off',
    'newline-before-return': 'error',
    'no-console': 'off',
    'no-restricted-syntax': 'off',
    'no-unused-expressions': ['error', { allowShortCircuit: true }],
    'no-underscore-dangle': 'off',
    'no-nested-ternary': 'off',
    'no-unused-vars': 'off',
    'arrow-body-style': 'off',
    // @typescript-eslint
    '@typescript-eslint/explicit-function-return-type': 'off',
    '@typescript-eslint/no-empty-function': 'off',
    '@typescript-eslint/prefer-interface': 'off',
    '@typescript-eslint/explicit-module-boundary-types': 'off',
    '@typescript-eslint/no-use-before-define': 'off',
    '@typescript-eslint/no-unused-vars': [
      'error',
      {
        varsIgnorePattern: '_',
        argsIgnorePattern: '^_',
      },
    ],
    '@typescript-eslint/naming-convention': [
      'error',
      {
        selector: 'variable',
        format: ['camelCase', 'PascalCase', 'UPPER_CASE'],
        filter: { regex: '^_|__', match: false },
      },
      {
        selector: 'function',
        format: ['camelCase', 'PascalCase'],
      },
      {
        selector: 'typeLike',
        format: ['PascalCase'],
      },
    ],
    //prettier
    'prettier/prettier': [
      'warn',
      {},
      {
        usePrettierrc: true,
      },
    ],
    // import
    'import/extensions': 'off',
    'import/prefer-default-export': 'off',
    'import/no-extraneous-dependencies': [
      'error',
      {
        devDependencies: ['src/**/*.stories.tsx'],
        peerDependencies: false,
      },
    ],
    // jsx-a11y
    'jsx-a11y/click-events-have-key-events': 'off',
    'jsx-a11y/no-noninteractive-element-interactions': 'off',
    'jsx-a11y/no-static-element-interactions': 'off',
    'jsx-a11y/img-redundant-alt': 'off',
    'jsx-a11y/anchor-is-valid': 'off',
    'jsx-a11y/label-has-associated-control': 'off',
    'jsx-a11y/interactive-supports-focus': 'off',
    // react
    'react/react-in-jsx-scope': 'off',
    'react/jsx-filename-extension': [
      'error',
      {
        extensions: ['.jsx', '.tsx'],
      },
    ],
    'react/jsx-one-expression-per-line': 'warn',
    'react/jsx-wrap-multilines': 'off',
    'react/no-array-index-key': 'off',
    'react/display-name': 'off',
    'react/button-has-type': 'off',
    'react/jsx-props-no-spreading': 'off',
    'react/jsx-one-expression-per-line': 'off',
    'react/require-default-props': 'off',
    'react/prop-types': 'off',
    // react-hooks
    'react-hooks/rules-of-hooks': 'error',
    'react-hooks/exhaustive-deps': 'error',
  },
  overrides: [
    {
      files: ['*.js'],
      rules: {
        '@typescript-eslint/no-var-requires': ['off'],
      },
    },
  ],
}
