import { Layout } from 'components/Layout'
import { Box } from '@chakra-ui/react'

export default function Index() {
  return (
    <Layout>
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
        Hello, Next!
      </Box>
    </Layout>
  )
}
