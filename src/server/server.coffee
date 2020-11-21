{createServer} = require 'http'
express        = require 'express'
path           = require 'path'

jwt     = require 'jsonwebtoken'
hasher  = require './services/hasher'
axios   = require 'axios'
cors    = require 'cors'
fs      = require 'fs'
helmet  = require 'helmet'


backEndEndpoint = process.env.WRESTLEDB_SERVER_ENDPOINT or "http://localhost:8081"

# MIDDLEWARE
{verifyToken} = require './services/verifyToken'
# {sessionServer} = require './sessionServer'

app = express()

app.set('port', process.env.PORT_TOURNAMENT or 3000)

app.use helmet()
app.use cors()
app.use express.json()
app.use express.urlencoded({extended: true})

app.use(express.static(path.resolve(__dirname, '../../lib/')))

app.post '/register', (req, res) ->
  return res.status(400).send("No Username/andOr/Password provided") unless req.body?.email and req.body?.password

  {name, email, password} = req.body

  hasher.hash password, (err, hashedPassword) ->
    axios.post("#{backEndEndpoint}/register", {name, email, hashedPassword}, {auth: {username: 'wrestledb', password: 'wdb'}})
      .then (response) ->
        dataToSendToVuex = JSON.parse(JSON.stringify(response.data))
        dataToSendToVuex.token = jwt.sign({ user:{name, email, hashedPassword} }, 'the_secret_key')
        # In a production app, you'll want the secret key to be an environment variable
        res.status(201).json(dataToSendToVuex).end()
      , (error) ->
        console.log "server 2 .error", error.toJSON()
        res.json(error.toJSON()).status(400).end()


app.post '/login', (req, res) ->
  axios.post("#{backEndEndpoint}/login", req.body, {auth: {username: 'wrestledb', password: 'wdb'}})
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

app.use "/", (req, res, next) ->
  console.log "\n\nGETTING CALLED\n\n"
  return next()

# app.use "/auth", sessionServer TODO: SETUP REDIS SESSION SERVER FOR PAYMENT AUTHENTICATION

app.get '/tournaments', verifyToken, (req, res) ->
  jwt.verify req.token, 'the_secret_key', (err) =>
    if err
      console.log "Tournaments ERROR!!!"
      res.sendStatus(401).redirect('/')
      # res.redirect('/')
    else
      res.json({events: [{tournamentName: "testTournament", id: 1, time:"4PM", date: "Tomorrow", title: "SwagFest"}]})

# app.use "/", (req, res) ->
#   res.redirect('/')

################################################################
# Startup
################################################################

server = createServer(app)

console.log "APP - Starting Server on port", app.get('port')
server.listen app.get('port')

console.log "APP - Server started on port %d in %s mode", app.get('port'), app.settings.env

process.on 'uncaughtException', (err) ->
  console.log "APP - caught an uncaught"
  console.error err
