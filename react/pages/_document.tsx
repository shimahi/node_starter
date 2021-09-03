import React from 'react'
import Document, { Html, Head, Main, NextScript, DocumentContext } from 'next/document'
import { extractCritical } from '@emotion/server'

export default function AppDocument() {
  return (
    <Html lang="ja">
      <Head></Head>
      <body>
        <Main />
        <NextScript />
      </body>
    </Html>
  )
}

AppDocument.getInitialProps = async (ctx: DocumentContext) => {
  const initialProps = await Document.getInitialProps(ctx)
  const styles = extractCritical(initialProps.html)

  return {
    ...initialProps,
    styles: (
      <>
        {initialProps.styles}
        {/* eslint-disable-next-line */}
        <style data-emotion-css={styles.ids.join('')} dangerouslySetInnerHTML={{ __html: styles.css }} />
      </>
    ),
  }
}
