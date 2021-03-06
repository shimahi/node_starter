import { ReactNode } from 'react'
import { ApolloClient, ApolloProvider, InMemoryCache, HttpLink } from '@apollo/client'
import { ChakraProvider } from '@chakra-ui/react'
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
    <ChakraProvider>{children}</ChakraProvider>
  </ApolloProvider>
)

export default AppProvider
