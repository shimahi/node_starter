const defaultConfig = {
  publicRuntimeConfig: {
    environment: process.env.NODE_ENV,
  },
  serverRuntimeConfig: {
    secret: process.env.SECRET,
  },
}

module.exports = defaultConfig
