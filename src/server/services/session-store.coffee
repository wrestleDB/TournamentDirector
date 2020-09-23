session = require 'express-session'
redisClient = require './redis-client'

module.exports = do ->
  RedisStore = require('connect-redis') session
  return new RedisStore(client: redisClient)
