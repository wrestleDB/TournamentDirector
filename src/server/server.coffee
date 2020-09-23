{createServer} = require 'http'
express = require 'express'
expressSession = require 'express-session'
helmet = require 'helmet'
path = require 'path'

database = require "./services/database"
sessionStore = require './services/session-store'

app = express()
server = createServer(app)

console.log "EXPRESS - Setting up configuration"

app.set('port', (process.env.PORT_TOURNAMENT or 4001))

app.use helmet()
app.use express.json()
app.use express.urlencoded({extended: true})

# Connect Database
database.connect()

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

app.get "/", (req, res, next) ->
  if req.session.viewCount then req.session.viewCount++ else req.session.viewCount = 1
  console.log "req.session: ", req.session
  return next()

# Static folder
app.use(express.static(path.resolve(__dirname, '../../lib/')))

# Handle SPA
# app.get(/.*/, (req, res) => res.sendFile(path.resolve(__dirname, '../client/index.html')))

################################################################
# Startup
################################################################
console.log "APP - Starting Server on port", app.get('port')
server.listen app.get('port')

console.log "APP - Server started on port %d in %s mode", app.get('port'), app.settings.env

process.on 'uncaughtException', (err) ->
  console.log "APP - caught an uncaught"
  console.error err