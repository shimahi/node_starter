require('dotenv').config({ path: '.env.local' })

module.exports = {
  schema: [
    {
      [`${process.env.NEXT_PUBLIC_GRAPHQL_ENDPOINT}`]: {},
    },
  ],
  documents: './src/graphql/*.graphql',
  overwrite: true,
  generates: {
    './src/types/graphql.ts': {
      plugins: ['typescript', 'typescript-operations', 'typescript-react-apollo'],
      config: {
        withHOC: false,
        withComponent: false,
        withHooks: true,
        reactApolloVersion: 3,
        gqlImport: '@apollo/client#gql',
        skipTypename: false,
        namingConvention: {
          transformUnderscore: true,
        },
      },
    },
  },
}
