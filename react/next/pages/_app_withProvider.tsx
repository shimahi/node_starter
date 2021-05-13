import { AppProps } from 'next/app'
import AppProvider from 'store'
import { ChakraProvider } from '@chakra-ui/react'

const App = ({ Component, pageProps }: AppProps) => {
  return (
    <AppProvider>
      <ChakraProvider>
        <Component {...pageProps} />
      </ChakraProvider>
    </AppProvider>
  )
}

export default App
