<template>
  <div id="navbar">
    <router-link to="/">Home Page </router-link>
    &nbsp;
    <router-link to="/myWrestlers">My Wrestlers Page</router-link>
    &nbsp;
    <div class="nav-bar-logout">
      <p class="wdb-primary ">{{username}}</p>
      <button type="submit" @click="logout()">Logout</button>
    </div>
  </div>
</template>

<script lang="coffee">
import { mapGetters, mapActions }  from 'vuex'
import axios from 'axios'

export default
  name: 'navBar'
  computed: mapGetters ['username']
  methods:
    logout: ->
      axios.get('/logout')
        # .then(this.$router.push('/'))
        .then(window.location.reload(true)) # TODO: Get this working - Need to refresh out

</script>

<style scoped>
.nav-bar-logout {
  color: #EB7D7A;
}
</style>