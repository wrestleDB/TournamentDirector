{createServer} = require 'http'
express = require 'express'
helmet = require 'helmet'
path = require 'path'

database = require "./services/database"

app = express()
server = createServer(app)

database.connect()

console.log "EXPRESS - Setting up configuration"

app.set('port', (process.env.PORT_TOURNAMENT or 4001))

app.use helmet()
app.use express.json()
app.use express.urlencoded({extended: true})

# Static folder
app.use(express.static(path.resolve(__dirname, '../../lib/')))

# Handle SPA
app.get(/.*/, (req, res) => res.sendFile(path.resolve(__dirname, '../client/index.html')))

################################################################
# Startup
################################################################
console.log "APP - Starting Server on port", app.get('port')
server.listen app.get('port')

console.log "APP - Server started on port %d in %s mode", app.get('port'), app.settings.env

process.on 'uncaughtException', (err) ->
  console.log "APP - caught an uncaught"
  console.error err