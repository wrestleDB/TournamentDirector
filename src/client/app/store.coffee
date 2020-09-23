import Vue from 'vue'
import Vuex from 'vuex'
import myWrestlers from './state/myWrestlers.coffee'
import user from './state/user.coffee'

Vue.use Vuex

export default new Vuex.Store({
  modules:
    user: user
    myWrestlers: myWrestlers
})