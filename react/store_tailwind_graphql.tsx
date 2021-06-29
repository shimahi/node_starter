import { ReactNode } from 'react'
import { ApolloClient, ApolloProvider, InMemoryCache, HttpLink } from '@apollo/client'
import { CacheProvider } from '@emotion/react'
import { cache as emotionCache } from '@emotion/css'
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

type AppProviderProps = {
  children: ReactNode
}

const AppProvider = ({ children }: AppProviderProps) => (
  <ApolloProvider client={client}>
    <CacheProvider value={emotionCache}>{children}</CacheProvider>
  </ApolloProvider>
)

export default AppProvider
