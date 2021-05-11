import 'ress'
import React from 'react'
import { render } from 'react-dom'
import { ChakraProvider, Box } from '@chakra-ui/react'

const App = () => (
  <ChakraProvider>
    <Box
      p={4}
      fontSize={{
        base: '3xl',
        md: '4xl',
        lg: '5xl',
        xl: '6xl',
      }}
      color="teal.600"
      fontWeight="bold"
    >
      Hello, React!
    </Box>
  </ChakraProvider>
)

render(<App />, document.getElementById('root'))
