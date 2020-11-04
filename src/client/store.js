import { createStore } from 'vuex'

const state = {
  tournaments: []
}


const getters = {
  allTournaments: (state) => state.matches
}

const actions = {
  async getTournaments({commit}) {
    let getTournaments = bent("json")
    let tournaments = await getTournaments("http://localhost:8081/tournaments")
    console.log("TOURNAMNEsT: ", tournaments)
  }
}


mutations = {}

store = createStore({state, getters, actions, mutations})

export default store
