import Head from 'next/head'
import { AppProps } from 'next/app'
import { ApolloClient, ApolloProvider, InMemoryCache, HttpLink } from '@apollo/client'
import { CacheProvider } from '@emotion/react'
import { cache as emotionCache } from '@emotion/css'
import 'ress'
import getConfig from 'next/config'

const {
  publicRuntimeConfig: { apiEndpoint },
} = getConfig()

const cache = new InMemoryCache()

const link = new HttpLink({
  uri: apiEndpoint,
})

const client = new ApolloClient({
  cache,
  link,
})

const App = ({ Component, pageProps }: AppProps) => {
  return (
    <ApolloProvider client={client}>
      <CacheProvider value={emotionCache}>
        <Head>
          <title>My Project</title>
          <meta charSet="UTF-8" />
          <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        </Head>
        <Component {...pageProps} />
      </CacheProvider>
    </ApolloProvider>
  )
}
export default App
