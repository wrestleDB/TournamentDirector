express = require 'express'
jwt     = require 'jsonwebtoken'
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
  if req.body
    user =
      name: req.body.name,
      email: req.body.email,
      password: req.body.password
      # In a production app, you'll want to encrypt the password

    data = JSON.stringify(user, null, 2)

    # dbUserEmail = require('./userdb.json').email
    errorsToSend = []

    # if (dbUserEmail is user.email)
    #   errorsToSend.push('An account with this email already exists.')

    # if (user.password.length < 5)
    #   errorsToSend.push('Password too short.')

    # if (errorsToSend.length > 0)
    #   res.status(400).json({ errors: errorsToSend })

    # else
    #   fs.writeFile './userdb.json', data, err =>
    #     if err
    #       console.log(err + data)
    #     else
    #       token = jwt.sign({ user }, 'the_secret_key')
    #       # In a production app, you'll want the secret key to be an environment variable
    #       res.json({
    #         token,
    #         email: user.email,
    #         name: user.name
    #       })
  else
    res.sendStatus(400)


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
