bent          = require 'bent'
hasher        = require './hasher'
passport      = require 'passport'
Strategy      = require('passport-local').Strategy

class Authentication

  init: (@app) ->
    console.log("AUTHENTICATION - Authentication init")
    passport.use @authStrategy()
    passport.serializeUser @serializeUser
    passport.deserializeUser @deserializeUser
    @app.use passport.initialize()
    @app.use passport.session()
    @app.use @setContext

  authStrategy: ->
    new Strategy (username, password, next) ->
      console.log "new Strategy: ", username, "\n", password, "\n"
      username = username?.toLowerCase().trim()
      return next(null, false) unless (username and password)

      try
        postRequest = bent('http://localhost:8081/', 'POST', 'json')
        userInfo = await postRequest('login', {username})
        return next(userInfo.error) if userInfo.error

      catch error
        return next(error)
      console.log "USER INFO: ", userInfo
      hasher.compare password, userInfo.password, (err, passwordMatches) ->
        console.log "err: ", err
        console.log "passwordMatches: ", passwordMatches
        return next("stop here -password invalid-") unless passwordMatches
        return next(null, userInfo)


  deserializeUser: (username, next) ->
    console.log "deserializeUser: ", username, "\n\n\n\n\n"
    try
      getJSON = bent('json')
      user = await getJSON("http://localhost:8081/user?username=#{username}")
      return next(null, user)

    catch error
      console.error "ERROR", error
      return next(false)

  serializeUser: (user, next) ->
    console.log "serializeUser: ", user
    return next(null, user.username)

  # Middleware -----------------------------------------------------------------
  setContext: (req, res, next) ->
    return next() unless req.user
    console.log "setting context: user--> ", req.user

    if req.user.error
      req.userContext = {}

    else
      req.userContext =
        user: req.user
        isAdmin: req.user.username is "aldon.isenberg2@gmail.com" # TODO: Implement this

    delete req.user

    return next()

  logout: (req, res, next) ->
    req.logout()
    delete req.userContext
    req.session.destroy()
    next()


module.exports = new Authentication()
