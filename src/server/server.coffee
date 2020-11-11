{createServer} = require 'http'
bent           = require 'bent'
express        = require 'express'
expressSession = require 'express-session'
helmet         = require 'helmet'
passport       = require 'passport'
path           = require 'path'
cors           = require 'cors'

authentication = require './services/authentication'
hasher         = require './services/hasher'
sessionStore   = require './services/session-store'

app = express()

app.use helmet()
app.use cors()
app.use express.json()
app.use express.urlencoded({extended: true})

console.log "EXPRESS - Setting up configuration"

app.set('port', (process.env.PORT_TOURNAMENT or 4001))

# Static folder
# app.use(express.static(path.resolve(__dirname, '../../lib/')))

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

app.get "/", (req, res, next) ->
  return next() if req.userContext?.user?._id
  res.send('<h1>Home</h1><p>Please <a href="/register">register</a></p><p>Please <a href="/login">login</a></p>')

app.get '/login', (req, res, next) ->
  form = '<h1>Login Page</h1><form method="POST" action="/login">\
  Enter Username:<br><input type="text" name="username">\
  <br>Enter Password:<br><input type="password" name="password">\
  <br><br><input type="submit" value="Submit"></form>'
  res.send(form)

app.post '/login', passport.authenticate('local', {successRedirect: '/' }), (err, req, res, next) ->
  if err then next(err)


app.get '/register', (req, res, next) ->
  form = '<h1>Register Page</h1><form method="post" action="register">\
  Enter Username:<br><input type="text" name="username">\
  <br>Enter Password:<br><input type="password" name="password">\
  <br><br><input type="submit" value="Submit"></form>'
  res.send(form)


app.post '/register', (req, res, next) ->
  console.log "\n\n\nHITTING SERVER 1", JSON.stringify(req.body, null, 2)
  return next("No Username/andOr/Password provided") unless req.body?.email and req.body?.password

  {email, password} = req.body


  hasher.hash password, (err, hashedPassword) ->
    return next(err) if err

    try
      request  = bent('http://localhost:8081/', 'POST', 'json')
      response = await request('register', {username:email, hashedPassword})
      console.log "Server 1 Register response:", JSON.stringify(response, null, 2)
      {error}  = response
      return next(error) if error
      return res.json(JSON.parse(JSON.stringify(response))).status(201).end()

    catch error
      return next(error)

# // Visiting this route logs the user out
app.get '/logout', (req, res, next) =>
  console.log "before-userContext: ", req.userContext
  authentication.logout req, res, (err) ->
    console.log "after-userContext: ", req.userContext
    res.redirect('/')

app.get '/login-failure', (req, res, next) ->
  res.send('You entered the wrong password.')

app.use (req, res, next) ->
  console.log "TESTING THIS HERE!!!"
  # TODO: fix routing for the originalUrl in production, see https://github.com/wrestleDB/TournamentDirector/issues/30
  console.log("req.originalUrl: ", req.originalUrl)
  return res.redirect('/') unless req.userContext
  next()

app.use(express.static(path.resolve(__dirname, '../../lib/')))

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