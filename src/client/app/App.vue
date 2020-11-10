<template>
  <div id="app">
    <nav-bar-login v-if="!loggedIn"/>
    <nav-bar v-else/>
    <router-view class="main"/>
  </div>
</template>

<script>
import NavBar from './navbar/NavBar.vue'
import NavBarLogin from './navbar/NavBarLogin.vue'

import { authComputed } from './helpers/vuexHelpers.js'


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
  }
}
</script>

<style>
@import '../../../public/css/app.css';
@import '../../../public/fontawesome/css/all.css';
</style>