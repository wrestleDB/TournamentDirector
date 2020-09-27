User          = require '../models/user'
passport      = require 'passport'
LocalStrategy = require('passport-local').Strategy

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
    new LocalStrategy (username, password, next) ->
      console.log "username: ", username
      console.log "password: ", password
      username = username?.toLowerCase().trim()
      return next(null, false) unless username
      # User.findOne {}, (err, user) ->
      User.findOne {username: username}, (err, user) ->
        console.log "User Found: ", user
        console.log "password match: ", password is user.password
        return next(err) if err
        return next(null, false) unless user
        return next(null, false) unless password is user.password
        console.log "got Here!!"
        return next(null, user)

  deserializeUser: (username, next) ->
    console.log "deserializeUser", username
    User.findOne {username: username} , (err, user) ->
      console.log "err"
      return next(err) if err
      return next(null, user)

  serializeUser: (user, next) ->
    console.log "serializeUser: ", user.username
    return next(null, user.username)

  # Middleware -----------------------------------------------------------------
  setContext: (req, res, next) ->
    return next() unless req.user
    console.log "setting context: user--> ", req.user

    req.userContext =
      user: req.user
      isAdmin: req.user.username is "aldon.isenberg2@gmail.com"

    delete req.user

    return next()

  # login: (req, res, next) ->
  #   delete req.session.passport.rootUser if req.session?.passport?.rootUser
  #   delete req.userContext.rootUser if req.context?.rootUser
  #   passport.authenticate('local', (err, context, info) ->
  #     return next(err) if err?
  #     unless context?.account? and context?.user?
  #       res.locals.loginResponse =
  #         success: false
  #         message: info or '<p>The username or password you entered is incorrect.</p>'
  #       return next()
  #     req.login context.user, (err) ->
  #       return next(err) if err?
  #       logger.logEventForUser "Logged in", context.account.toEventObj(), context.user, context.account
  #       req.session.cookie.maxAge = 2592000000 #30*24*60*60*1000 Rememeber 'me' for 30 days
  #       res.cookie 'landing', landing.signupVariant, {maxAge: 31536000000, httpOnly: false}
  #       resp = {success: true}
  #       if req.body.redirectTo
  #         resp.redirectTo = req.body.redirectTo
  #       res.locals.loginResponse = resp
  #       next()
  #   )(req, res, next)

  logout: (req, res, next) ->
    req.logout()
    delete req.userContext
    req.session.destroy()
    next()


module.exports = new Authentication()
