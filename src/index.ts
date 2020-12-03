import express from 'express'
import { ApolloServer, gql } from 'apollo-server-express'

const typeDefs = gql`
  type Query {
    hello: String
  }
`

const resolvers = {
  Query: {
    hello: () => 'Hello world!',
  },
}

const server = new ApolloServer({ typeDefs, resolvers })

const app = express()

server.applyMiddleware({ app })

app.get('/', (req, res) => {
  res.json({
    message: 'いぬ〜',
  })
})

app.listen({ port: 4000 }, () => {
  console.log('Example app listening on http://localhost:4000')
  console.log(`GraphQL Server are running on ${server.graphqlPath}!`)
})
