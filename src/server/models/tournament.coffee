mongoose       = require 'mongoose'

bracketTypes: ['double-elimination', 'round-robin', 'dual', 'dual-round-robin']

UserSchema = new mongoose.Schema
  created   : type: Date, default: Date.now
  eventName : String
  registration :
    entryFee       : type: Number, required: true
    inviteOnly     : type: Boolean, default: false
    openDate       : type: Date, default: Date.now
    closeDate      : type: Date, required: true
    earlyDiscount  : Number # Discount for signing up early
    earlyOpenDate  : Date # Open date for early discount to apply
    earlyCloseDate : Date # Close date for early discount to apply
  eventDate :
    startDate : type: Date
    endDate   : type: Date
  location : # Send me location
     address  : String
     address2 : String
     city     : String
     state    : String
     postalCode: String
     country  : type: String, default: "US"
     lat      : Number
     lng      : Number
     timezone : String
  bracketType : type: String, enum: bracketTypes




UserSchema.set 'toJSON', {getters : true} # output the virtual getters when calling toJSON

# Virtuals ---------------------------------------------------------------------

UserSchema.virtual('name').get ->
  @eventName

# Methods ----------------------------------------------------------------------
UserSchema.methods.checkForEarlyDiscount = (registrationDate, done) ->
  return false # TODO: Fix this

module.exports = mongoose.model 'users', UserSchema
module.exports.Schema = UserSchema