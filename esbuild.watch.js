const { build } = require('esbuild')
const glob = require('glob')
const entryPoints = glob.sync('./src/**/*.ts')

build({
  entryPoints,
  outbase: './src',
  outdir: './dist',
  platform: 'node',
  external: [],
  watch: true,
})
