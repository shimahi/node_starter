module.exports = function (api) {
  api.cache(true)

  const plugins = ['babel-plugin-twin', 'babel-plugin-macros']
  const presets = [
    [
      'next/babel',
      {
        'preset-react': {
          runtime: 'automatic',
          importSource: '@emotion/react',
        },
      },
    ],
  ]

  return { plugins, presets }
}
