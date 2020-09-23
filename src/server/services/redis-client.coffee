redis = require 'redis'
url = require 'url'

module.exports = do ->
  redisUrl = url.parse process.env.REDIS_CLIENT_WRESTLEDB
  redisClient = redis.createClient redisUrl.port, redisUrl.hostname
  redisClient.auth(redisUrl.auth.split(":")[1]) if redisUrl.auth
  return redisClient
