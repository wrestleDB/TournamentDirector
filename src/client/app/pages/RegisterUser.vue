<template>
<div id="SignUpForm">
  <form @submit.prevent="register">
		<h2>Create Account</h2>
		<div>
			<label>First Name</label>
			<input type="text" name="firstName" placeholder="Enter first name">
		</div>
		<div>
			<label>Last Name</label>
			<input v-model="name" type="text" name="lastName" placeholder="Enter last name">
		</div>
		<div>
			<label>Email</label>
			<input v-model="email" type="email" name="email" placeholder="champ@wrestleDB.com">
		</div>
		<div>
			<label>Password</label>
			<input v-model="password" type="password" name="password">
		</div>
		<!-- <div>
			<label>Role</label>
			<select name="role">
				<option value="Director">Director</option>
				<option value="Coach">Coach</option>
				<option value="Parent">Parent</option>
			</select>
		</div>

		<div>
			<label>Birthday:</label>
			<input type="date" name="birthday">
		</div> -->
		<button type="submit" name="submit">Submit</button>
	</form>
  <hr>
  <ul>
    <li v-for="(error, index) in errors" :key="index">
      {{ error }}
    </li>
  </ul>
  <router-link to="/login">
    Already have an account? Login.
  </router-link>
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
          firstName: this.firstName,
          lastName: this.lastName,
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