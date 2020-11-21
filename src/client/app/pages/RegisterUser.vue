<template>
  <div>
    <form @submit.prevent="register">
      <label for="name">
        Name:
      </label>
      <input v-model="name" type="text" name="name" value>
<hr>
      <label for="email">
        Email:
      </label>
      <input v-model="email" type="email" name="email" value>
<hr>
      <label for="password">
        Password:
      </label>
      <input v-model="password" type="password" name="password" value>
<hr>
      <button type="submit" name="button">
        Register
      </button>

      <ul>
        <li v-for="(error, index) in errors" :key="index">
          {{ error }}
        </li>
      </ul>

      <router-link to="/login">
        Already have an account? Login.
      </router-link>
    </form>
  </div>
</template>

<script>
export default {
  data () {
    return {
      name: '',
      email: '',
      password: '',
      errors: null
    }
  },
  methods: {
    register () {
      // In a production app, you'll want to encrypt the password
      this.$store
        .dispatch('register', {
          name: this.name,
          email: this.email,
          password: this.password
        })
        .then(() => {
          this.$router.push({ name: 'all-tournaments' })
        })
        .catch(err => {
          this.errors = err.response.data.errors
        })
    }
  }
}
</script>

<style scoped>
</style>
