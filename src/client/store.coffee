import { createStore } from 'vuex'

state =
  user:
    _id: ""
    username: "default@username.com"
  tournament:
    eventName      : ""
    status         : "new" # ["new", "step1", "step2", "complete"]
    bracketType    : "double-elimination"
    numberOfMats   : ""
    eventDate      :
      startDate: ""
      endDate  : ""
    location:
      address    : ""
      address2   : ""
      city       : ""
      state      : ""
      postalCode : ""
      country    : "US"
      lat        : 0
      lng        : 0
      timezone   : ""
    registration:
      numberOfMats   : ""
      entryFee       : ""
      inviteOnly     : ""
      openDate       : ""
      closeDate      : ""
      minWrestlers   : ""
      maxWrestlers   : ""
      earlyDiscount  : ""
      earlyOpenDate  : ""
      earlyCloseDate : ""

getters =
  tournament: (state) -> return state.tournament
  status: (state) -> return state.tournament.status

actions =
  addTournament:  ->
    tournament = JSON.stringify(@)
    axios.put('http:localhost:8081/tournaments', {tournament})
      .then((a, b, c) ->
        console.log("Add Tournament - A: ", a)
        console.log("Add Tournament - B: ", b)
        console.log("Add Tournament - C: ", c)
      )
  validateTournamentData: ->
    return false unless this.eventName
    return true


mutations = {}

store = createStore({state, getters, actions, mutations})

export default store
