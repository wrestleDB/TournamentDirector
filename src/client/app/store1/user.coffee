import axios from 'axios'
# url = 'api/users/'
authenticationURL = "http://localhost:4001/login"

state =
  currentJWT: ''
  username: 'aldon.isenberg2@gmail.com'


getters =
  authenticated: (state) -> state.currentJWT? and state.currentJWT isnt ''
  currentJWT: (state) -> state.currentJWT
  username: (state) -> state.username

actions =
  login: ({commit}, creds) ->

  logout: ({commit}, creds) ->

  checkCreds: ({commit}, creds) ->
    try
      console.log "Checking Creds!!1", JSON.stringify(creds, null, 2)

      response = await axios.post(authenticationURL, creds)

      console.log "Response: ", JSON.stringify(response, null, 2)
      if response.data?.token?
        console.log "Token returned successfully"
        commit('setJWT', "123abc456def")
        return
    catch error
      console.log "checkCreds Error: ", error
    commit('setJWT', "")

mutations =
  setJWT: (state, jwt) ->
    localStorage.setItem('wrestlingCoachToken', jwt)
    state.currentJWT = jwt





export default {
  state,
  getters,
  actions,
  mutations
}