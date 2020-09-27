mongoose       = require 'mongoose'
hasher         = require '../services/hasher'

UserSchema = new mongoose.Schema
  username      : String
  password      : String
  hash          : String
  salt          : String

UserSchema.set 'toJSON', {getters : true} # output the virtual getters when calling toJSON

#compare passwords
UserSchema.methods.checkPassword = (password, done) ->
  hasher.compare password, @password, done

module.exports = mongoose.model 'users', UserSchema
module.exports.Schema = UserSchema