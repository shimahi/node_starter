import express from 'express'

const app = express()

app.get('/', (req, res) => {
  res.json({
    message: 'いぬ〜',
  })
})

const PORT = 3000

app.listen(PORT, () => {
  console.log(`Example app listening on port ${PORT}!`)
})
