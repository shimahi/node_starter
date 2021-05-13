const path = require('path')
const { ESBuildMinifyPlugin } = require('esbuild-loader')
const { serverRuntimeConfig, publicRuntimeConfig } = require('./runtime.config')

function useEsbuildMinify(config, options) {
  const terserIndex = config.optimization.minimizer.findIndex(
    (minimizer) => minimizer.constructor.name === 'TerserPlugin',
  )
  if (terserIndex > -1) {
    config.optimization.minimizer.splice(terserIndex, 1, new ESBuildMinifyPlugin(options))
  }
}

function useEsbuildLoader(config, options) {
  const jsLoader = config.module.rules.find((rule) => rule.test && rule.test.test('.js'))

  if (jsLoader) {
    jsLoader.use.loader = 'esbuild-loader'
    jsLoader.use.options = options
  }
}

module.exports = (phase, { defaultConfig }) => {
  return {
    webpack: (config, { isServer, webpack }) => {
      if (!isServer) {
        config.node = {
          fs: 'empty',
        }
      }

      config.plugins.push(
        new webpack.ProvidePlugin({
          React: 'react',
        }),
      )

      useEsbuildMinify(config)
      useEsbuildLoader(config, {
        loader: 'tsx',
        target: 'es2020',
      })

      config.resolve.alias['@'] = path.join(__dirname, 'src')

      return config
    },
    reactStrictMode: true,
    publicRuntimeConfig,
    serverRuntimeConfig,
  }
}
