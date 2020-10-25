<template>
  <div id="my-tournaments">
    <h1><i class="fad fa-home-lg"></i> List of my Tournaments</h1>
    <button @click="getTournamentList">Get Tournaments from DB</button>
    <p>Tournament 1 <i class="fad fa-globe-americas"></i></p>
    <p>Tournament 2 <i class="fad fa-lock-alt"></i> (invite only)</p>
    <p>Tournament 3 <i class="fad fa-lock-open-alt"></i> (invite only) (you were invited)</p>
    <br/>
    <li v-if="latestTournament.error"> Error: {{latestTournament.error}}</li>
    <li v-else v-for="tournament in state.tournaments" :key="tournament._id">
      <span>Name: {{tournament.eventName}}</span>
      <span>, Id: {{tournament._id}}</span>
    </li>
  </div>
</template>

<script>
import { reactive, computed, onMounted } from 'vue'
import bent from 'bent'

export default {
  name: "tournamentsList",
  data: () => {
    return {
      tournaments: [{
        error: "No tournaments found"
      }]
    }
  },
  computed: {
    latestTournament() {
      return this.tournaments[0]
    }
  },
  methods: {
    getTournamentList: async function () {
      let getTournaments = bent("json")
      let tournaments = await getTournaments("http://localhost:8081/tournaments")
      console.log("TOURNAMNEsT: ", tournaments)
    }
  }
}
</script>

<style>

</style>