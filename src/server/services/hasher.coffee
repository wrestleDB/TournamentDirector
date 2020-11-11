bcrypt = require 'bcrypt'

# Used for Server Side
exports.hash = (word, callback) ->
  bcrypt.genSalt 10, (err, salt) ->
    bcrypt.hash word, salt, (err, hash) ->
      callback err, hash

# Used for JWT Server
exports.hashPassword = (word, callback) ->
  bcrypt.genSalt 12, (err, salt) ->
    bcrypt.hash word, salt, (err, hash) ->
      callback err, hash

# This is set on the client side store
# exports.hashClientPassword = (word, callback) ->
#   bcrypt.genSalt 8, (err, salt) ->
#     bcrypt.hash word, salt, (err, hash) ->
#       callback err, hash

exports.compare = (word, hash, callback) ->
  bcrypt.compare word, hash, (err, result) ->
    callback(err, result)
