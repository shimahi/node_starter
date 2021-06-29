const defaultConfig = {
  publicRuntimeConfig: {
    environment: process.env.NODE_ENV,
    apiEndpoint: process.env.GRAPHQL_ENDPOINT,
  },
  serverRuntimeConfig: {
    secret: process.env.SECRET,
  },
}

module.exports = defaultConfig
