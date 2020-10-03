<template>
  <div id="app">
    <nav-bar/>
    <router-view class="main"/>
  </div>
</template>

<script lang="coffee">
import NavBar from './NavBar.vue'

export default
  name: 'app'
  components:
    'nav-bar': NavBar

</script>

<style>
@import '../../../public/css/app.css';
@import '../../../public/fontawesome/css/all.css';
</style>