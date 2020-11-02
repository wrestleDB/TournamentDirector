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
        <p><input v-model="eventName" placeholder="Tournament Name"/> Tournament name is: {{eventName}}</p><br>

        <div>
          <span>Select Date: {{eventDate.startDate?.toHTTP()}}</span>
          <DatePicker
            title="tournamentStart"
            v-model="eventDate.startDate"/>
          <span> ^^^^ Click Here</span>
        </div>


      </div>

      <div v-show="currentStep === 2">
        <p><input v-model="location.address" placeholder="Where"/> Where? {{location.address || "___"}} TODO: implement google maps</p>
        <p><input v-model="location.postalCode" placeholder="Postal Code"/> PostalCode? {{location.postalCode || "___"}}</p>
        <p><input v-model="location.city" placeholder="City"/> City? {{location.city || "___"}} </p>
        <p><input v-model="location.state" placeholder="State"/> State? {{location.State || "___"}} </p>
      </div>

      <div v-show="currentStep === 3">
        <p><input v-model="registration.numberOfMats" placeholder="Number of Mats"/> How Many Mats?  {{registration.numberOfMats || "___"}}</p><br>
        <p><input v-model="registration.minWrestlers" placeholder="Min # of Wrestlers"/> {{registration.minWrestlers || "___"}} Min # of Wrestlers</p><br>
        <p><input v-model="registration.maxWrestlers" placeholder="Max # of Wrestlers"/> {{registration.maxWrestlers || "___"}} Max # of Wrestlers</p><br>
        <p><input v-model="bracketType" placeholder="double-elimination or round-robin"/> Bracket Type: {{bracketType || "___"}}, TODO: make this dropdown with additional params</p>
      </div>

      <div v-show="currentStep === 4">
        <p>Registration opens: {{registration.entryOpenDate || "___"}} Registration closes: {{registration.entryCloseDate || "___"}}</p><br>
        <!-- <DatePicker title="registrationOpenClose"/> -->
        <p><input v-model="registration.entryFee" placeholder="How much $"/> Entry Fee Cost is ${{registration.entryFee || "___"}}</p><br>
        <p><input v-model="registration.inviteOnly" placeholder="Invite Only?"/> Invite only? {{registration.inviteOnly || "___"}} (meaning only certain teams can register)</p>
      </div>

      <div v-show="currentStep === 5">
        <h1>Summary:</h1>
        <p>eventName: {{eventName}}</p><br>
        <p>bracketType: {{bracketType}}</p><br>
        <p>numberOfMats: {{numberOfMats}}</p><br>
        <p>eventDate: {{eventDate}}</p><br>
        <p>location: {{location}}</p><br>
        <p>registration: {{registration}}</p><br>
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
import {reactive, computed, toRefs, ref } from 'vue'
import {DateTime} from 'luxon'

export default {
  setup() {
    const tournament = reactive({
      eventName      : "",
      status         : "new", // ["new", "step1", "step2", "complete"]
      bracketType    : "double-elimination",
      numberOfMats   : "",
      eventDate      : {
        startDate: null,
        endDate  : null,
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
    })

    const currentStep = ref(1)

    const canGoBack    = computed(() => currentStep.value > 1)
    const canGoForward = computed(() => currentStep.value < 5)

    const goForward = () => {currentStep.value++}
    const goBack    = () => {currentStep.value--}

    const setTournamentDates = () => {console.log("Setting Tournament Dates Function")}

    return {...toRefs(tournament), currentStep, canGoBack, canGoForward, goForward, goBack, setTournamentDates}
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
.container{
  display: flex;
}
.fixed{
  width: 30px;
}
.flex-item{
  flex-grow: 1;
}

</style>