const path = require('path')
const { serverRuntimeConfig, publicRuntimeConfig } = require('./runtime.config')

module.exports = (phase, { defaultConfig }) => {
  return {
    webpack: (config, { webpack }) => {
      config.resolve.alias['@'] = path.join(__dirname, 'src')
      return config
    },
    reactStrictMode: true,
    publicRuntimeConfig,
    serverRuntimeConfig,
  }
}
