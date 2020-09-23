<template>
  <div class="login">

    <h1>Login Page</h1>

    <div>
      <label for="email">Username/Email</label>
      <input id="username" name="username" type="email" v-model="creds.username">
    </div>

    <div>
      <label for="email">Password</label>
      <input id="password" name="password" type="password" v-model="creds.password">
    </div>

    <div>
      <button type="submit" @click="checkCreds(creds)">Login</button>
    </div>

    <div>
      Authenticated: {{authenticated}}
      Username: {{creds.username}}
      password: {{creds.password}}
      currentJWT: {{currentJWT}}
    </div>

  </div>
</template>

<script lang="coffee">
import { mapGetters, mapActions }  from 'vuex'

export default
  name     : 'login'
  computed : mapGetters ['currentJWT','authenticated']
  methods  : mapActions ['checkCreds']
  data     : => return
    creds:
      username: ''
      password: ''

</script>

<style>

</style>