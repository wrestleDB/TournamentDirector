<template>
  <div id="app">
    <nav-bar/>
    <router-view/>
  </div>
</template>

<script>
import NavBar from './NavBar.vue'

export default {
  components: {
    'nav-bar': NavBar
  }
}
</script>

<style>

</style>