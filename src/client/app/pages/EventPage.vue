<template>
  <div>
    <h1>Event Page </h1>
    <p>So we have a list of tournaments, when the user clicks one of the tiles, they should be directed to a "dashboard" page that has all the tourney details for that specific tournament.</p>
    <span> I say dashboard because we could list out</span>
    <ul>
      <li> Number of wrestlers entered </li>
      <li> Entry Fee's collected </li>
      <li> Countdown to tournament </li>
      <li> teams entered, </li>
      <li> wrestlers entered </li>
      <li> Button to start weigh-ins (). </li>
      <li> Button to start tournament (should be disabled until tournament start date, or force start). </li>
      <li><a href="https://github.com/wrestleDB/TournamentDirector/issues/53" target="__blank">Github Issue</a></li>
    </ul>

    <p>Data here: {{event}}</p>
  </div>
</template>

<script>
import axios from 'axios'
import {ref} from 'vue'

export default {
  setup(props, context) {
    console.log("SETUP - event page props, context: ", {props, context})
    const event = ref({})
    return {event}
  },
  async created() {
    console.log("CREATED - route params: ", this.$route.params)
    const result = await axios.get(`/api/event/${this.$route.params?.id}`)
    console.log("THE RESPONSE", {result})
    this.event = result.data
  }
}
</script>

<style>

</style>