<template>
  <div id="add-tournament">
    <h1><i class="fad fa-home-lg"></i> Add Tournament</h1>
    <p><input v-model="eventName" placeholder="Tournament Name"/> Tournament name is: {{eventName || "___"}}</p>
    <p><input v-model="registration.numberOfMats" placeholder="Number of Mats"/> How Many Mats? --> {{registration.numberOfMats || "___"}}</p>
    <p><input v-model="registration.minWrestlers" placeholder="Min # of Wrestlers"/> {{registration.minWrestlers || "___"}} Min # of Wrestlers</p>
    <p><input v-model="registration.maxWrestlers" placeholder="Max # of Wrestlers"/> {{registration.maxWrestlers || "___"}} Max # of Wrestlers</p>
    <p><input v-model="eventDate.startDate" placeholder="Start Date"/> Start Date? {{eventDate.startDate || "___"}} TODO: implement date picker</p>
    <p><input v-model="eventDate.endDate" placeholder="When"/> End Date? {{eventDate.endDate || "___"}} TODO: implement date picker</p>
    <p><input v-model="location.address" placeholder="Where"/> Where? {{location.address || "___"}} TODO: implement google maps</p>
    <p><input v-model="registration.entryFee" placeholder="How much $"/> Entry Fee Cost is ${{registration.entryFee || "___"}}</p>
    <p>Registration opens: {{registration.entryOpenDate || "___"}} Registration closes: {{registration.entryCloseDate || "___"}}</p>
    <p>
      <input v-model="registration.entryOpenDate" placeholder="Registration Opens"/> to
      <input v-model="registration.entryCloseDate" placeholder="Registration Closes"/>
    </p>
    <p><input v-model="registration.inviteOnly" placeholder="Invite Only?"/> Invite only? {{registration.inviteOnly || "___"}} (meaning only certain teams can register)</p>
    <p><input v-model="bracketType" placeholder="double-elimination or round-robin"/> Bracket Type: {{bracketType || "___"}}, TODO: make this dropdown with additional params</p>
    <button @click="addTournament(this)">click this button</button>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  methods: {
    addTournament() {
      let tournament = JSON.stringify(this)

      axios.put('http://localhost:8081/tournaments', {tournament})
        .then((a, b, c) => {
            console.log("Add Tournament - A: ", a)
            console.log("Add Tournament - B: ", b)
            console.log("Add Tournament - C: ", c)
          }
        )
    },
    validateTournamentData() {
      if (!this.eventName) return false
      return true
    }
  },
  data() {
    return {
      eventName      : "",
      bracketType    : "double-elimination",
      numberOfMats   : "",
      eventDate      : {
        startDate: "",
        endDate: ""
      },
      location: {
        address    : "",
        address2   : "",
        city       : "",
        state      : "",
        postalCode : "",
        country    : "US",
        lat        : 0,
        lng        : 0,
        timezone   : ""
      },
      registration: {
        numberOfMats   : "",
        entryFee       : "",
        inviteOnly     : "",
        openDate       : "",
        closeDate      : "",
        minWrestlers   : "",
        maxWrestlers   : "",
        earlyDiscount  : "",
        earlyOpenDate  : "",
        earlyCloseDate : ""
      }


    }
  }
}
</script>

<style>

</style>