import { createStore } from 'vuex'
import axios from 'axios'

state =
  user: localStorage.getItem('user') or null

getters =
  loggedIn: (state) -> state.user

actions =
  register: ({ commit }, credentials) ->
    return axios
      .post('//localhost:3000/register', credentials)
      .then(({ data }) => commit('SET_USER_DATA', data))

  login: ({ commit }, credentials) ->
    return axios
      .post('//localhost:3000/login', credentials)
      .then(({ data }) => commit('SET_USER_DATA', data))

  logout: ({ commit }) ->
    commit('CLEAR_USER_DATA')

mutations =
  SET_USER_DATA: (state, userData) ->
    state.user = userData
    localStorage.setItem('user', JSON.stringify(userData))
    axios.defaults.headers.common['Authorization'] = "Bearer #{userData.token}"

  CLEAR_USER_DATA: () ->
    localStorage.removeItem('user')
    location.reload()

store = createStore({state, getters, actions, mutations})

export default store
