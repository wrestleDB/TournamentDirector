import Vue from 'vue'
import Vuex from 'vuex'
import myWrestlers from './myWrestlers.coffee'
import user from './user.coffee'

Vue.use Vuex

export default new Vuex.Store({
  modules:
    user: user
    myWrestlers: myWrestlers
})