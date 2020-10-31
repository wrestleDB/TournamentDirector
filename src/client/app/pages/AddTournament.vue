<template>
  <div id="add-tournament">
    <h1>
      <i class="fad fa-home-lg"></i> Add Tournament
    </h1>
      <div class="container-progressbar">
          <ul class="progressbar">
            <li v-bind:class="{active: currentStep > 0}">Name/Date</li>
            <li v-bind:class="{active: currentStep > 1}">Location</li>
            <li v-bind:class="{active: currentStep > 2}">Details</li>
            <li v-bind:class="{active: currentStep > 3}">Registration</li>
            <li v-bind:class="{active: currentStep > 4}">Finished</li>
          </ul>
      </div>
    <br>
    <hr>
    <hr>
    <div class="regcard">
      <div v-show="currentStep === 1">
        <p><input v-model="tournament.eventName" placeholder="Tournament Name"/> Tournament name is: {{tournament.eventName || "___"}}</p><br>
        <p>Tournament starts: {{tournament.eventDate.startDate || "___"}} Tournament ends: {{tournament.eventDate.endDate || "___"}}</p>
        <DatePicker title="tournament" v-bind:tournament-dates="Testing" />
      </div>

      <div v-show="currentStep === 2">
        <p><input v-model="tournament.location.address" placeholder="Where"/> Where? {{tournament.location.address || "___"}} TODO: implement google maps</p>
      </div>

      <div v-show="currentStep === 3">
        <p><input v-model="tournament.registration.numberOfMats" placeholder="Number of Mats"/> How Many Mats?  {{tournament.registration.numberOfMats || "___"}}</p><br>
        <p><input v-model="tournament.registration.minWrestlers" placeholder="Min # of Wrestlers"/> {{tournament.registration.minWrestlers || "___"}} Min # of Wrestlers</p><br>
        <p><input v-model="tournament.registration.maxWrestlers" placeholder="Max # of Wrestlers"/> {{tournament.registration.maxWrestlers || "___"}} Max # of Wrestlers</p><br>
        <p><input v-model="tournament.bracketType" placeholder="double-elimination or round-robin"/> Bracket Type: {{tournament.bracketType || "___"}}, TODO: make this dropdown with additional params</p>
      </div>

      <div v-show="currentStep === 4">
        <p>Registration opens: {{tournament.registration.entryOpenDate || "___"}} Registration closes: {{tournament.registration.entryCloseDate || "___"}}</p><br>
        <DatePicker title="registration"/>
        <p><input v-model="tournament.registration.entryFee" placeholder="How much $"/> Entry Fee Cost is ${{tournament.registration.entryFee || "___"}}</p><br>
        <p><input v-model="tournament.registration.inviteOnly" placeholder="Invite Only?"/> Invite only? {{tournament.registration.inviteOnly || "___"}} (meaning only certain teams can register)</p>
      </div>

      <div v-show="currentStep === 5">
        <h1>Summary:</h1>
        <p>EventName: {{tournament.name}}</p><br>
        <p>Bracket Type: {{tournament.bracketType}}</p><br>
        <p>Tournament: {{tournament}}</p><br>
        <button @click="addTournament()">Create Tournament</button>
      </div>
    </div>
    <hr>
    <div v-show="true" style="text-align: center">
        <div>
          <button v-if="canGoBack" @click="goBack">
            <i class="fad fa-arrow-to-left"></i>
            Go Back
          </button>

          <button v-else disabled hidden>
            Start
          </button>

          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Current Step:&nbsp;{{currentStep}}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

          <button v-if="canGoForward" @click="goForward">
            Next Step
            <i class="fad fa-arrow-to-right"></i>
          </button>

          <button v-else disabled hidden>
                End
          </button>
        </div>
    </div>
    <hr>
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
      this.currentStep += 1
    }
  },
  data: () => {
    return {
      currentStep : 1,
    }
  },
  components: {
    DatePicker
  }
}
</script>

<style scoped>
.regcard {
  width: 100%;
  min-height: 350;
  text-align: left;
  padding: 20;
}
.container-progressbar {
  width: 100%;
  margin: auto;
  padding-bottom: 50;
}
.progressbar {
  counter-reset: step 0;
}
.progressbar li {
  list-style-type: none;
  width: 20%;
  float: left;
  font-size: 14px;
  position: relative;
  text-align: center;
  text-transform: uppercase;
  color: #363636;
}
.progressbar li:before {
  width: 30px;
  height: 30px;
  content: counter(step);
  counter-increment: step;
  line-height: 30px;
  border: 4px solid #6d6d6d;
  display: block;
  text-align: center;
  margin: 0 auto 10px auto;
  border-radius: 50%;
  background-color: white;
}
.progressbar li:after {
  width: 100%;
  height: 10px;
  content: '';
  position: absolute;
  background-color: #6d6d6d;
  top: 15px;
  left: -50%;
  z-index: -1;
}
.progressbar li:first-child:after {
  content: none;
}
.progressbar li.active {
  color: #363636;
}
.progressbar li.active:before {
  border-color: #1bb630;
  background-color: #fafafa
}
.progressbar li.active:after {
  background-color: #1bb630;
  transition-timing-function: linear;
}
</style>