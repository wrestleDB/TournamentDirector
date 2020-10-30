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
  addEventDate: ({commit}, dateInformation) ->
    {name, type, date} = dateInformation
    switch name
      when "tournamentStartEnd" then switch type
        when "start" then commit('setTournamentStart', date)
        when "end"   then commit('setTournamentEnd',   date)

      when "registrationOpenClose" then switch type
        when "start" then commit('setRegistrationStart',  date)
        when "end"   then commit('setRegistrationEnd',    date)


  addRegistrationDates: ({commit}, registrationDates) ->
    console.log "registrationDates: ", JSON.stringify(registrationDates, null, 2)
    commit('setRegistrationDates', registrationDates)

  addTournament:  ->
    console.log "Adding Tournament: ", JSON.stringify(@, null, 2)
    # tournament = JSON.stringify(@)
    # TODO: insert 'bent' here
    # axios.put('http:localhost:8081/tournaments', {tournament})
    #   .then((a, b, c) ->
    #     console.log("Add Tournament - A: ", a)
    #     console.log("Add Tournament - B: ", b)
    #     console.log("Add Tournament - C: ", c)
    #   )

  validateTournamentData: ->
    return false unless this.eventName
    return true


mutations =
  setTournamentStart: (state, date) =>
    console.log "Setting TournamentStart", JSON.stringify(date, null, 2)
    console.log "State: ", state
    state.tournament.eventDate.startDate = date

  setTournamentEnd: (state, date) =>
    console.log "Setting TournamentEnd", JSON.stringify(date, null, 2)
    state.tournament.eventDate.endDate = date

  setRegistrationStart: (state, date) =>
    console.log "Setting Registration Start", JSON.stringify(date, null, 2)
    state.tournament.registration.openDate = date

  setRegistrationEnd: (state, date) =>
    console.log "Setting Registration Close", JSON.stringify(date, null, 2)
    state.tournament.registration.closeDate = date

store = createStore({state, getters, actions, mutations})

export default store
