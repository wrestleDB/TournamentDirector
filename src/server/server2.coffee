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

  hasher.hashPassword password, (err, hashedPassword) ->
    user = {name, email, password: hashedPassword}

    axios.post("http://localhost:4001/register", user)
      .then (response) ->
        dataToSendToVuex = JSON.parse(JSON.stringify(response.data))
        dataToSendToVuex.token = jwt.sign({ user }, 'the_secret_key')
        # In a production app, you'll want the secret key to be an environment variable

        res.status(201).json(dataToSendToVuex).end()
      , (error) ->
        console.log "server 2 .error", error.toJSON()
        res.json(error.toJSON()).status(400).end()

app.post '/login', (req, res) =>
  # userDB = fs.readFileSync('./userdb.json')
  # userInfo = JSON.parse(userDB)
  userInfo = {
    email: "dad"
  }

  # if (req.body and req.body.email is userInfo.email and req.body.password is userInfo.password)
  if true
    token = jwt.sign({ userInfo }, 'the_secret_key')
    # In a production app, you'll want the secret key to be an environment variable
    res.json({
      token,
      email: userInfo.email,
      name: userInfo.name
    })
  else
    res.status(401).json({ error: 'Invalid login. Please try again.' })



app.listen 3000, ->
  console.log('AUTH - Client Side Auth Server started on port 3000')
