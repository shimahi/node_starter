import { ReactNode } from 'react'
import { ApolloClient, ApolloProvider, InMemoryCache, HttpLink } from '@apollo/client'
import getConfig from 'next/config'

const {
  publicRuntimeConfig: { GRAPHQL_ENDPOINT },
} = getConfig()

const cache = new InMemoryCache()

const link = new HttpLink({
  uri: GRAPHQL_ENDPOINT,
})

const client = new ApolloClient({
  cache,
  link,
})

type AppProviderProps = {
  children: ReactNode
}

const AppProvider = ({ children }: AppProviderProps) => <ApolloProvider client={client}>{children}</ApolloProvider>

export default AppProvider
