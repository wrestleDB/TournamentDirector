{createServer} = require 'http'
express        = require 'express'
path           = require 'path'

jwt     = require 'jsonwebtoken'
hasher  = require './services/hasher'
axios   = require 'axios'
cors    = require 'cors'
fs      = require 'fs'
helmet  = require 'helmet'
morgan  = require 'morgan'


backEndEndpoint = process.env.WRESTLEDB_SERVER_ENDPOINT or "http://localhost:8081"
authentication  = {auth: {username: 'wrestledb', password: 'wdb'}}
# console.log axios.defaults.auth
axios.defaults.auth = {username: 'wrestledb', password: 'wdb'}
# MIDDLEWARE
{verifyToken} = require './services/verifyToken'
# {sessionServer} = require './sessionServer'

app = express()

app.set('port', process.env.PORT or 3000)

app.use helmet()
app.use cors()
app.use morgan(':method :url :status :response-time ms - :res[content-length]')
app.use express.json()
app.use express.urlencoded({extended: true})

app.use(express.static(path.resolve(__dirname, '../../lib/')))

# app.use "/", (req, res, next) ->
#   return next() if req.originalUrl.startsWith('/api/')
#   res.status(400).send("Malformed URL").end()

app.post '/api/register', (req, res) ->
  console.log "\nStarting Register: ", req.body
  return res.status(400).send("No Username/andOr/Password provided") unless req.body?.email and req.body?.password

  {firstName, lastName, email, password} = req.body

  hasher.hash password, (err, hashedPassword) ->
    axios.post("#{backEndEndpoint}/register", {firstName, lastName, email, hashedPassword}, authentication)
      .then (response) ->
        dataToSendToVuex = JSON.parse(JSON.stringify(response.data))
        dataToSendToVuex.token = jwt.sign({ user:{firstName, lastName, email, hashedPassword} }, 'the_secret_key')
        # In a production app, you'll want the secret key to be an environment variable
        res.status(201).json(dataToSendToVuex).end()
      .catch (error) ->
        console.log "server 2 .error", error.toJSON()
        res.json(error.toJSON()).status(400).end()

app.post '/api/login', (req, res) ->
  axios.post("#{backEndEndpoint}/login", req.body, authentication)
    .then (response) ->
      console.log("login - response: ", response.data)
      user = response.data

      hasher.compare req.body.password, user.password, (err, result) ->
        console.log {err, result}
        if not result
          res.status(401).json({ error: 'Invalid login. Please try again.' }).end()

        else
          token = jwt.sign({ user }, 'the_secret_key')
          # In a production app, you'll want the secret key to be an environment variable
          res.json({
            token,
            email: user.email,
            name: user.name
          }).status(200).end()

    .catch (error) ->
      console.log "POST api login  response error: ", error.toJSON()
      res.json(error.toJSON()).status(400).end()
# app.use "/auth", sessionServer TODO: SETUP REDIS SESSION SERVER FOR PAYMENT AUTHENTICATION

app.get '/api/event/:id', verifyToken, (req, res) ->
  console.log "get api/event params: ", req.params
  # res.json(req.params).status(200).end()
  res.json({error: "no id supplied"}).status(400).end() unless req.params.id

  jwt.verify req.token, 'the_secret_key', (err) =>
    if err
      console.log "Event ERROR!!!"
      res.sendStatus(401).redirect('/')
      # res.redirect('/')
    else
      axios.get("#{backEndEndpoint}/event/#{req.params.id}")
        .then (response) ->
          console.log "RESPONSE: ", response.data
          res.json(response.data).status(200).end()

        .catch (error) ->
          console.log "GET tournaments response error: ", error
          res.json(error).status(400).end()

app.get '/api/tournaments', verifyToken, (req, res) ->
  jwt.verify req.token, 'the_secret_key', (err) =>
    if err
      console.log "Tournaments ERROR!!!"
      res.sendStatus(401).redirect('/')
      # res.redirect('/')
    else
      axios.get("#{backEndEndpoint}/tournaments")
        .then (response) ->
          console.log "RESPONSE: ", response.data
          res.json(response.data).status(200).end()


        .catch (error) ->
          console.log "GET tournaments response error: ", error
          res.json(error).status(400).end()
      # res.json({events: [{tournamentName: "testTournament", id: 1, time:"4PM", date: "Tomorrow", title: "SwagFest"}]})

app.post '/api/tournaments', verifyToken, (req, res) ->
  console.log "req: ", req.body
  jwt.verify req.token, 'the_secret_key', (err) =>
    if err
      console.log "POST Tournaments ERROR!!!"
      res.sendStatus(401).redirect('/')
      # res.redirect('/')
    else
      axios.post("#{backEndEndpoint}/tournaments", req.body, authentication)
        .then (response) ->
          console.log("post - response: ", response.data)
          res.status(201).json(response.data).end()
        .catch (error) ->
          console.log "POST tournaments response error: ", error.toJSON()
          res.json(error.toJSON()).status(400).end()
      # res.json({events: [{tournamentName: "testTournament", id: 1, time:"4PM", date: "Tomorrow", title: "SwagFest"}]})


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
