import axios from 'axios'
# url = 'api/wrestlers/'
url = "http://localhost:8081/wrestlers"

state =
  wrestlers: [{
    _id: "111"
    name: "wrestler Adam"
  }, {
    _id: "112",
    name: "wrestler Eve"
  }]

getters =
  allWrestlers: (state) => state.wrestlers

actions =
  getWrestlers: ({ commit }) =>
    response = await axios.get(url)
    commit('setWrestlers', response.data)

  # addWrestler: ({ commit }, wrestler) =>
  #   response = await axios.post(url, wrestler)
  #   commit('newWrestlerAdded', response.data)

mutations =
  setWrestlers: (state, wrestlers) => (state.wrestlers = wrestlers),
  # newWrestler: (state, wrestler) => (state.wrestlers.unshift(wrestler))

export default {
  state,
  getters,
  actions,
  mutations
}