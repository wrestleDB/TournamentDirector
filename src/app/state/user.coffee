import axios from 'axios'
# url = 'api/users/'
authentication = "http://localhost:8081/authenticate"

state =
  # currentJWT: localStorage.getItem('wrestlingCoachToken') or ''
  currentJWT: ''


getters =
  authenticated: (state) => state.currentJWT? and state.currentJWT isnt ''
  currentJWT: (state) => state.currentJWT
  # jwt: (state) => state.currentJWT
  # TODO: change commented code to coffeescriptm --> https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Expressions_and_Operators
  # jwtData: (state, getters) => state.currentJWT ? JSON.parse(atob(getters.jwt.split('.')[1])) : null,
  # jwtSubject: (state, getters) => getters.jwtData ? getters.jwtData.sub : null,
  # jwtIssuer: (state, getters) => getters.jwtData ? getters.jwtData.iss : null

actions =
  checkCreds: ({commit}, creds) =>
    console.log "Checking Creds!!1", JSON.stringify(creds, null, 2)
    try
      response = await axios.post(authentication, creds)
      console.log "Response: ", JSON.stringify(response, null, 2)
      if response.data?.token?
        console.log "Token returned successfully"
        commit('setJWT', "123abc456def")
        return
    console.log "username/password incorrect"
    commit('setJWT', "")



  # fetchJWT: ({ commit }, { username, password }) =>
  #   # Perform the HTTP request.
  #   res = await fetch("http://localhost/vuejs-jwt-example/auth?u=${username}&p=${password}")
  #   # Calls the mutation defined to update the state's JWT.
  #   commit('setJWT', await res.text());

mutations =
  setJWT: (state, jwt) =>
    localStorage.setItem('wrestlingCoachToken', jwt)
    state.currentJWT = jwt





export default {
  state,
  getters,
  actions,
  mutations
}