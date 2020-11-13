{createServer} = require 'http'
express        = require 'express'
expressSession = require 'express-session'
passport       = require 'passport'
path           = require 'path'
authentication = require './services/authentication'
sessionStore   = require './services/session-store'

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

app.set('port', (3000 or process.env.PORT_TOURNAMENT or 3000))

# Setup Express Session
app.use(expressSession({
  name: "session_cookie"
  secret: 'some secret' # TODO: create environment variable here
  resave: false
  saveUninitialized: true
  store: sessionStore
  cookie:
    httpOnly: true
    maxAge: 6048000000 # 70 days
}))

# Setup Authentication
authentication.init(app)


app.use(express.static(path.resolve(__dirname, '../../lib/')))

# app.get '/', (req, res) ->
#   # TODO: Here is where I want to send the valid SPA HTML.
#   res.json({ message: 'Welcome to the API.'})

app.use '/login', (req, res, next) ->
  console.log "LOOKY HERE",req.body
  return next()

app.post '/login', passport.authenticate('local', {successRedirect: '/' }), (err, req, res, next) ->
  console.log "ERROR: ", {err}
  if err then next(err)

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

app.post '/loginUpdated', (req, res) ->
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

app.get '/tournaments', verifyToken, (req, res) ->
  jwt.verify req.token, 'the_secret_key', (err) =>
    if err
      res.sendStatus(401)
    else
      res.json({events: [{tournamentName: "testTournament"}]})

# // Visiting this route logs the user out
app.get '/logout', (req, res, next) =>
  console.log "before-userContext: ", req.userContext
  authentication.logout req, res, (err) ->
    console.log "after-userContext: ", req.userContext
    # res.redirect('/')
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
