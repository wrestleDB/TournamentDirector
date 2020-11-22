import { createStore } from 'vuex'
import axios from 'axios'

# TODO, fix this to point to /api of this project (connect webpack proxy), remove direct call

state =
  user: null

getters =
  loggedIn: (state) -> state.user?

actions =
  register: ({ commit }, credentials) ->
    return axios
      .post("/register", credentials)
      .then(({ data }) => commit('SET_USER_DATA', data))

  login: ({ commit }, credentials) ->
    {email, password} = credentials
    return axios
      .post("/login", {username: email, password})
      .then(({ data }) =>
        console.log {data}
        commit('SET_USER_DATA', data))

  logout: ({ commit }) ->
    commit('CLEAR_USER_DATA')

mutations =
  SET_USER_DATA: (state, userData) ->
    console.log "VUEX - SETTING USER DATA ", userData
    state.user = userData
    localStorage.setItem('user', JSON.stringify(userData))
    axios.defaults.headers.common['Authorization'] = "Bearer #{userData.token}"
    console.log "axios.defaults.headers", axios.defaults.headers.common

  CLEAR_USER_DATA: () ->
    localStorage.removeItem('user')
    location.reload()

store = createStore({state, getters, actions, mutations})

export default store
