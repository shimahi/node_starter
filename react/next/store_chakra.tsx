import { ReactNode } from 'react'
import { ChakraProvider } from '@chakra-ui/react'

type AppProviderProps = {
  children: ReactNode
}

const AppProvider = ({ children }: AppProviderProps) => <ChakraProvider>{children}</ChakraProvider>

export default AppProvider
