express = require 'express'
jwt     = require 'jsonwebtoken'
hasher  = require './services/hasher'
axios   = require 'axios'
cors    = require 'cors'
fs      = require 'fs'
helmet  = require 'helmet'

# MIDDLEWARE
{verifyToken} = require './services/verifyToken'

app = express()

app.use helmet()
app.use cors()
app.use express.json()
app.use express.urlencoded({extended: true})

app.get '/', (req, res) ->
  res.json({ message: 'Welcome to the API.'})


app.get '/tournaments', verifyToken, (req, res) ->
  jwt.verify req.token, 'the_secret_key', (err) =>
    if err
      res.sendStatus(401)
    else
      res.json({events: [{tournamentName: "testTournament"}]})


app.post '/register', (req, res) ->
  console.log "\n\n\nHITTING SERVER 2", JSON.stringify(req.body, null, 2)
  return res.status(400).send("No Username/andOr/Password provided") unless req.body?.email and req.body?.password

  {name, email, password} = req.body

  hasher.hash password, (err, hashedPassword) ->
    axios.post("http://localhost:8081/register", {name, email, hashedPassword})
      .then (response) ->
        dataToSendToVuex = JSON.parse(JSON.stringify(response.data))
        dataToSendToVuex.token = jwt.sign({ user:{name, email, hashedPassword} }, 'the_secret_key')
        # In a production app, you'll want the secret key to be an environment variable
        res.status(201).json(dataToSendToVuex).end()
      , (error) ->
        console.log "server 2 .error", error.toJSON()
        res.json(error.toJSON()).status(400).end()

app.post '/login', (req, res) ->
  axios.post("http://localhost:8081/login", req.body)
    .then (response) ->
      console.log("login - response: ", response.data)
      user = response.data

      hasher.compare req.body.password, user.password, (err, result) ->
        console.log {err, result}
        if not result
          res.status(401).json({ error: 'Invalid login. Please try again.' })
        else
          token = jwt.sign({ user }, 'the_secret_key')
          # In a production app, you'll want the secret key to be an environment variable
          res.json({
            token,
            email: user.email,
            name: user.name
          })

app.listen 3000, ->
  console.log('AUTH - Client Side Auth Server started on port 3000')
