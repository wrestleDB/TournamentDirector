<template>
  <div id="LoginForm">
    <form @submit.prevent="login">
      <h2>Login</h2>
      <div>
        <label>Email</label>
        <input v-model="email" type="email" name="email" placeholder="champ@wrestleDB.com">
      </div>
      <div>
        <label>Password</label>
        <input v-model="password" type="password" name="password">
      </div>
      <button type="submit" name="submit">Submit</button>
    </form>

    <p>{{ error }}</p>

    <router-link to="/registerUser">
      Don't have an account? Register.
    </router-link>
  </div>
</template>

<script>
export default {
  data () {
    return {
      email: '',
      password: '',
      error: null
    }
  },
  methods: {
    login () {
      this.$store
        .dispatch('login', {
          email: this.email,
          password: this.password
        })
        .then(() => {
          this.$router.push({ name: 'all-tournaments' })
        })
        .catch(err => {
          console.log("Error: ", err)
          this.error = err.response.data.error
        })
    }
  }
}
</script>

<style scoped>
form {
  margin-left: 50%;
  transform: translateX(-50%);
  text-align: right;
  padding: 10;
  border-radius: 1px;
  display: inline-block;
  background-color: #f2f2f2;
  box-shadow: 5px 10px 2em #888888;
  align-self: center;
}
h2{
	text-align: center;
	font-size: 2rem;
}
label{
	padding: 5em .5em;
}
input{
  width: 15rem;
  font-family:'arial';
  padding: .5em .5em;
  margin: 1em .25em;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
}
select{
  width: 15rem;
  font-family:'arial';
  padding: .5em .5em;
  margin: 1em .25em;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
}
</style>
