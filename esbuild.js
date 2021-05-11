const { build } = require('esbuild')
const { argv } = require('process')
const path = require('path')
const glob = require('glob')

build({
  entryPoints: glob.sync(path.resolve(__dirname, 'src/**/*.ts')),
  minify: argv[2] === 'production',
  bundle: true,
  watch: argv[3] && argv[3] === 'watch',
  outbase: path.resolve(__dirname, 'src'),
  outdir: path.resolve(__dirname, 'dist'),
  tsconfig: path.resolve(__dirname, 'tsconfig.json'),
  platform: 'node',
  external: [],
})
