import { createRouter, createWebHistory } from 'vue-router' # there is also createWebHashHistory and createMemoryHistory
import Home          from './app/pages/Home.vue'
import AddTournament from './app/pages/AddTournament.vue'
import Tournaments   from './app/pages/Tournaments.vue'
import Locations     from './app/pages/Locations.vue'
import Teams         from './app/pages/Teams.vue'
import Wrestlers     from './app/pages/Wrestlers.vue'
import UserAdmin     from './app/pages/UserAdmin.vue'
import NotFound      from './app/pages/NotFound.vue'

import Login         from './app/pages/Login.vue'
import RegisterUser  from './app/pages/RegisterUser.vue'


# Migration Guide: https://next.router.vuejs.org/guide/migration/#new-features
# TODO # https://router.vuejs.org/guide/advanced/navigation-guards.html#global-before-guards

router = createRouter({
  history: createWebHistory()
  routes: [
    { path: '/',                name: 'home',            component: Home,          meta: {requiresAuth: true} }
    { path: '/login',           name: 'login',           component: Login                                     }
    { path: '/registerUser',    name: 'register-user',   component: RegisterUser                              }
    { path: '/addTournament',   name: 'add-tournament',  component: AddTournament, meta: {requiresAuth: true} }
    { path: '/allTournaments',  name: 'all-tournaments', component: Tournaments,   meta: {requiresAuth: true} }
    { path: '/allLocations',    name: 'all-locations',   component: Locations,     meta: {requiresAuth: true} }
    { path: '/allTeams',        name: 'all-teams',       component: Teams,         meta: {requiresAuth: true} }
    { path: '/allWrestlers',    name: 'all-wrestlers',   component: Wrestlers,     meta: {requiresAuth: true} }
    { path: '/userAdminPage',   name: 'user-admin-page', component: UserAdmin,     meta: {requiresAuth: true} }
    { path: '/:pathMatch(.*)*', name: 'not-found',       component: NotFound                                  }
  ]
})

router.beforeEach (to, from, next) ->
  loggedIn = localStorage.getItem('user')
  console.log "BeforeEach - loggedIn?: ", loggedIn

  if (to.matched.some((record) -> record.meta.requiresAuth) and not loggedIn)
    console.log("Did not make it past authentication!")
    next('/login')
  else
    console.log("Made it past authentication!")
    next()

export default router
