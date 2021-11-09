# Node.js STARTER

Node.jsアプリの環境構築を行うシェルスクリプトです。

TypeScript, ESLint, prettier, huskyを使用し、以下のNode.js環境を作ることができます。

1. Node.jsでのバッチ処理開発環境
2. React(Next.js)によるWeb開発環境
3. 3に加えてApollo Clientとgraphql-codegenを利用するGraphQLクライアント環境

パッケージマネージャはYarn、ビルドツールにはesbuildを用いています(next.jsの場合はwebpack)

動作環境
Node.js `^15.5.1`
Yarn `^1.22.4`


### 使用方法
引数にアプリ名をつけて `source` または `.` コマンドを実行してください。

アプリ名がディレクトリ名になります。

```
$ source ./init.sh YOUR_APP_NAME
```

途中、それぞれの環境を作るかどうか問われるので、yまたはN + Enterを押してください
```
Reactの環境構築を行いますか?[y/N]:  y # Nの場合 1.
GraphQLの環境構築を行いますか?[y/N]:  y # Nの場合 2.
# 全て y の場合 3.が作成される
```


### 1. Node.js開発
`src/` 下にTypeScriptファイルを記述し、 esbuildを用いてビルドしてください。ビルドされたファイルは `dist/` 下に出力されるので、node.jsにより実行可能です。

```
# ビルド
$ yarn build

# 監視ビルド
$ yarn watch
```

```
# 実行
node dist/index.js
```


### 2. React開発
`src/index.tsx` をエントリーポイントとしてReactのコードを記述し、esbuildを用いてビルドします。ビルドが行われると、`dist/`下にindex.jsが出力されるので、予め用意してある `dist/index.html` をブラウズすることでアプリが確認できます。

Live Serverなどでローカルサーバを立てつつ監視ビルドを行うことで、HMRライクな開発が可能となります。

こちらは練習用のセットアップなので、本格的にフロントエンド環境を整える場合は 3 のNext.jsを構築してください。

```
# ビルド
$ yarn build

# 監視ビルド
$ yarn watch

# アプリを開く 
$ open dist/index.html  #（或いは、ローカルのhttpサーバを立ててください。）
```


### 2. Next.js開発
nextを用いてローカルサーバを起動し、`src/` 下にReact(Next.js)のコードを記述し開発を行ってください。

```
# ローカルサーバー起動
$ yarn dev # → http://localhost:3000
```

### 4. Next.js + GraphQL開発
基本的に3と同じです。 `src/store.tsx` にApollo Clientプロパイダーについての設定が記述されているので、目的に応じて変更してください。
また、 `codegen.js`にはgraphql-codegenの設定が記述してあり、`.envrc` の `GRAPHQL_ENDPOINT` を適切なURLに変更し、graphql-codegenを実行することで、 `src/types/graphql.ts` に対して型生成・カスタムフック生成が行われます。

```
# graphql-codegen実行
$ yarn codegen
```
