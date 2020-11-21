<template>
  <div id="user-admin">
    <h1> User Admin Page</h1>
    <p>Setup Billing</p>
    <p>Change/update Account Information</p>
    <p>Data/analytics pretty Graphs for profit-per-tournament & lifetime profit.</p>
    <!-- <span v-html="returnedHTML"> -->
    {{returnedHTML}}
    <!-- </span> -->
  </div>

</template>

<script>
import axios from 'axios'

export default {
  async created() {
    console.log("Admin Page: ")
    // const result = await axios.post('http://localhost:3000/auth/login', {username:"aldan@wrestledb.com", password: "aldan"})
    // console.log("HERE IS DATA: ", result)
    // this.returnedHTML = result.data
    // axios.get('http://localhost:3000/auth/logout')
  },
  data() {
    returnedHTML: ""
  }
}
</script>

<style>

</style>