<template>
  <div id="app">
    <nav-bar-login v-if="!loggedIn"/>
    <nav-bar v-else/>
    <router-view class="main"/>
  </div>
</template>

<script>
import axios from 'axios'
import NavBar from './navbar/NavBar.vue'
import NavBarLogin from './navbar/NavBarLogin.vue'

import { authComputed } from '../helpers/vuexHelpers.js'


export default {
  name: 'app',
  components: {
    'nav-bar': NavBar,
    'nav-bar-login': NavBarLogin
  },
  computed: {
    ...authComputed
  },
  created() {
    console.log("loggedIn: ", this.loggedIn)
    const userString = localStorage.getItem('user')
    if (userString) {
      const userData = JSON.parse(userString)
      this.$store.commit('SET_USER_DATA', userData)
    }
    axios.interceptors.response.use(
      response => response,
      error => {
        if (error.response.status === 401) {
          this.$store.dispatch('logout')
        }
        console.log({error})
        return Promise.reject(error)
      }
    )
    console.log("loggedIn: ", this.loggedIn)
  }
}
</script>

<style>
@import '../../../public/css/app.css';
@import '../../../public/fontawesome/css/all.css';
</style>