import axios from 'axios'
import Vue from 'vue'
import VueRouter from 'vue-router'

import store from './store/index.coffee'

import Home from './pages/Home.vue'
import AddTournament from './pages/AddTournament.vue'
# import MyWrestlers from './pages/MyWrestlers.vue'
import NotFound from './pages/NotFound.vue'


# https://router.vuejs.org/guide/advanced/navigation-guards.html#global-before-guards

Vue.use VueRouter

# axios.defaults.baseUrl = process.env.WRESTLEDB_SERVER or "http://localhost:8081"

router = new VueRouter
  routes: [
    { path: '/',              name: 'home',          component: Home        }
    { path: '/addTournament', name: 'addTournament', component: AddTournament }
    # { path: '/myWrestlers', name: 'myWrestlers', component: MyWrestlers }
    { path: '*',              name: 'notFound',    component: NotFound    }
  ]

# router.beforeResolve (to, from, next) ->
#   console.log "\n\n\nto: ", to
#   console.log "\n\n\nfrom: ", from
#   console.log "jwt token: ", store.state.user.currentJwt
#   console.log "localStorage: ", localStorage.getItem('wrestlingCoachToken')
#   console.log "\n\n\nThis: ", store.getters.authenticated
#   switch
#     when to.name in ['home', 'login'] then next()
#     when store.getters.authenticated  then next()
#     else next({name: 'login'})

export default router
