<template>
  <div id="add-tournament">
    <div>

    </div>
    <h1>
      <i class="fad fa-home-lg"></i> Add Tournament
    </h1>

    <hr>

    <div v-show="true">
      <div>
        <button v-if="canGoBack" @click="goBack">
          <i class="fad fa-arrow-left"></i>
          Go Back
        </button>

        <button v-else disabled>
          <i class="fad fa-arrow-to-left"></i>
          Go Back
        </button>

        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Current Step:&nbsp;{{currentStep}}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

        <button v-if="canGoForward" @click="goForward">
          <i class="fad fa-arrow-right"></i>
          Go Forward
        </button>

        <button v-else disabled>
          <i class="fad fa-arrow-to-right"></i>
          Go Forward
        </button>
      </div>
    </div>

    <hr>

    <div v-show="currentStep === 1">
      <p><input v-model="tournament.eventName" placeholder="Tournament Name"/> Tournament name is: {{tournament.eventName || "___"}}</p>
      <p><input v-model="tournament.location.address" placeholder="Where"/> Where? {{tournament.location.address || "___"}} TODO: implement google maps</p>
    </div>


    <div v-show="currentStep === 2">
      <p><input v-model="tournament.registration.numberOfMats" placeholder="Number of Mats"/> How Many Mats?  {{tournament.registration.numberOfMats || "___"}}</p>
      <p><input v-model="tournament.registration.minWrestlers" placeholder="Min # of Wrestlers"/> {{tournament.registration.minWrestlers || "___"}} Min # of Wrestlers</p>
      <p><input v-model="tournament.registration.maxWrestlers" placeholder="Max # of Wrestlers"/> {{tournament.registration.maxWrestlers || "___"}} Max # of Wrestlers</p>
      <p><input v-model="tournament.registration.entryFee" placeholder="How much $"/> Entry Fee Cost is ${{tournament.registration.entryFee || "___"}}</p>
      <p><input v-model="tournament.registration.inviteOnly" placeholder="Invite Only?"/> Invite only? {{tournament.registration.inviteOnly || "___"}} (meaning only certain teams can register)</p>
      <p><input v-model="tournament.bracketType" placeholder="double-elimination or round-robin"/> Bracket Type: {{tournament.bracketType || "___"}}, TODO: make this dropdown with additional params</p>
    </div>

    <div v-show="currentStep === 3">
      <p>Tournament starts: {{tournament.eventDate.startDate || "___"}} Tournament ends: {{tournament.eventDate.endDate || "___"}}</p>
      <DatePicker title="tournamentStartEnd"/>
    </div>

    <div v-show="currentStep === 4">
      <p>Registration opens: {{tournament.registration.entryOpenDate || "___"}} Registration closes: {{tournament.registration.entryCloseDate || "___"}}</p>
      <DatePicker title="registrationOpenClose"/>
    </div>

    <div v-show="currentStep === 5">
      <h1>Review Data:</h1>
      <p>{{JSON.stringify(tournament, null, 2)}}</p>
      <button @click="addTournament()">click this button</button>
    </div>

  </div>
</template>

<script>
import { mapGetters, mapActions }  from 'vuex'
import { DateTime } from 'luxon'
import DatePicker from '../components/DatePicker.vue'

export default {
  name: 'addTournamentPage',
  computed: {
    ...mapGetters(['tournament', 'status']),
    canGoBack() {
      return this.currentStep > 1
    },
    canGoForward() {
      return this.currentStep < 5
    }
  },
  methods: {
    ...mapActions(['addTournament', 'validateTournamentData']),
    getGoogleMapsAPI() {
      console.log("getGoogleAPI")
    },
    goBack() {
      this.currentStep += -1
    },
    goForward() {
      this.currentStep +=1
    }
  },
  data: () => {
    return {
      currentStep : 1
    }
  },
  components: {
    DatePicker
  }
}
</script>

<style>
</style>