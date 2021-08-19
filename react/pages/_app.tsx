import Head from 'next/head'
import { AppProps } from 'next/app'
import { CacheProvider } from '@emotion/react'
import { cache as emotionCache } from '@emotion/css'
import 'ress'

const App = ({ Component, pageProps }: AppProps) => {
  return (
    <CacheProvider value={emotionCache}>
      <Head>
        <title>My Project</title>
        <meta charSet="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      </Head>
      <Component {...pageProps} />
    </CacheProvider>
  )
}
export default App
