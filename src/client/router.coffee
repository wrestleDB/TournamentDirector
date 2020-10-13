import { createRouter, createWebHistory } from 'vue-router'
# ^there is also createWebHashHistory and createMemoryHistory

import Home          from './app/pages/Home.vue'
import AddTournament from './app/pages/AddTournament.vue'
import Tournaments   from './app/pages/Tournaments.vue'
import Locations     from './app/pages/Locations.vue'
import Teams         from './app/pages/Teams.vue'
import Wrestlers     from './app/pages/Wrestlers.vue'
import UserAdmin     from './app/pages/UserAdmin.vue'
import NotFound      from './app/pages/NotFound.vue'

# Migration Guide: https://next.router.vuejs.org/guide/migration/#new-features
# TODO # https://router.vuejs.org/guide/advanced/navigation-guards.html#global-before-guards

router = createRouter({
  history: createWebHistory()
  routes: [
    { path: '/',                name: 'home',            component: Home }
    { path: '/addTournament',   name: 'add-tournament',  component: AddTournament }
    { path: '/allTournaments',  name: 'all-tournaments', component: Tournaments }
    { path: '/allLocations',    name: 'all-locations',   component: Locations }
    { path: '/allTeams',        name: 'all-teams',       component: Teams }
    { path: '/allWrestlers',    name: 'all-wrestlers',   component: Wrestlers }
    { path: '/userAdminPage',   name: 'user-admin-page', component: UserAdmin }
    { path: '/:pathMatch(.*)*', name: 'not-found',       component: NotFound }
  ]
})

export default router
