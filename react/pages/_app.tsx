import { AppProps } from 'next/app'
import AppProvider from 'store'

const App = ({ Component, pageProps }: AppProps) => {
  return (
    <AppProvider>
      <Component {...pageProps} />
    </AppProvider>
  )
}
export default App
