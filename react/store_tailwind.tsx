import { ReactNode } from 'react'
import { CacheProvider } from '@emotion/react'
import { cache as emotionCache } from '@emotion/css'

type AppProviderProps = {
  children: ReactNode
}

const AppProvider = ({ children }: AppProviderProps) => {
  return <CacheProvider value={emotionCache}>{children}</CacheProvider>
}

export default AppProvider
