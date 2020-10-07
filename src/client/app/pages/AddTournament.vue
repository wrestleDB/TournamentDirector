<template>
  <div id="add-tournament">
    <h1><i class="fad fa-home-lg"></i> Add Tournament</h1>
    <p><input v-model="eventName" placeholder="Tournament Name"/> Tournament name is: {{eventName || "___"}}</p>
    <p><input v-model="numberOfMats" placeholder="Number of Mats"/> How Many Mats? --> {{numberOfMats || "___"}}</p>
    <p><input v-model="minWrestlers" placeholder="Min # of Wrestlers"/> {{minWrestlers || "___"}} Min # of Wrestlers</p>
    <p><input v-model="maxWrestlers" placeholder="Max # of Wrestlers"/> {{maxWrestlers || "___"}} Max # of Wrestlers</p>
    <p><input v-model="eventDate" placeholder="When"/> When? {{eventDate || "___"}} TODO: implement date picker</p>
    <p><input v-model="eventLocation" placeholder="Where"/> Where? {{eventLocation || "___"}} TODO: implement google maps</p>
    <p><input v-model="entryFee" placeholder="How much $"/> Entry Fee Cost is ${{entryFee || "___"}}</p>
    <p>Registration opens: {{entryOpenDate || "___"}} Registration closes: {{entryCloseDate || "___"}}</p>
    <p>
      <input v-model="entryOpenDate" placeholder="Registration Opens"/> to
      <input v-model="entryCloseDate" placeholder="Registration Closes"/>
    </p>
    <p><input v-model="entryInviteOnly" placeholder="Invite Only?"/> Invite only? {{entryInviteOnly || "___"}} (meaning only certain teams can register)</p>
    <p><input v-model="bracketType" placeholder="traditional or round-robin"/> Bracket Type: {{bracketType || "___"}}, TODO: make this dropdown with additional params</p>
    <button @click="addTournament">click this button</button>
  </div>
</template>

<script>
export default {
  methods: {
    addTournament() {
      console.log("Adding Tournament!!!!!!", this.eventName)
      if (this.validateTournamentData()) {
        console.log("tournament was validated, adding")
      } else {
        console.log("Tournament was not validated")
      }
    },
    validateTournamentData() {
      if (!this.eventName) return false
      return true
    }
  },
  data() {
    return {
      eventName      : "",
      numberOfMats   : "",
      minWrestlers   : "",
      maxWrestlers   : "",
      eventDate      : "",
      eventLocation  : "",
      entryFee       : "",
      entryOpenDate  : "",
      entryCloseDate : "",
      entryInviteOnly: "",
      bracketType    : ""
    }
  }
}
</script>

<style>

</style>