<template>
  <div id="my-tournaments">
    <h1><i class="fad fa-home-lg"></i> List of my Tournaments</h1>
    <button @click="getTournamentList">Get Tournaments from DB</button>
    <p>Tournament 1 <i class="fad fa-globe-americas"></i></p>
    <p>Tournament 2 <i class="fad fa-lock-alt"></i> (invite only)</p>
    <p>Tournament 3 <i class="fad fa-lock-open-alt"></i> (invite only) (you were invited)</p>
    <li v-for="tournament in tournaments" :key="tournament._id">
      <span>Name: {{tournament.name}}</span>
      <span>, Id: {{tournament._id}}</span>
    </li>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  name     : "tournamentsList",
  data : () => {
    return {
      tournaments: [{
        _id: "111",
        name: "Default1"
      }, {
        _id: "112",
        name: "Default2"
      }]
    }
  },
  methods: {
    getTournamentList: () => axios.get('http://localhost:8081/tournaments').then(
      (a, b, c) => {
        console.log("A: ", a)
        console.log("B: ", b)
        console.log("C: ", c)
      }
    )
  }
}
</script>

<style>

</style>