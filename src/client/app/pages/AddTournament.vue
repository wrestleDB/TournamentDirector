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
    <div class="regcard">
      <div v-show="currentStep === 1">
        <InputField v-model="eventName" label="Tournament Name"/>

        <DatePicker
          title="tournamentStart"
          v-model="eventDate.startDate"
        /><span> ^^^^ Select Start Date: {{eventDate.startDate?.toHTTP()}}</span>
      </div>

      <div v-show="currentStep === 2">
        <InputField v-model="location.address" label="Address"/><br>
        <InputField v-model="location.postalCode" label="Postal Code"/><br>
        <InputField v-model="location.city" label="City"/><br>
        <InputField v-model="location.state" label="State"/><br>
      </div>

      <div v-show="currentStep === 3">
        <InputField v-model="registration.numberOfMats" label="# of Mats"/><br>
        <InputField v-model="registration.minWrestlers" label="Min # of Wrestlers"/><br>
        <InputField v-model="registration.maxWrestlers" label="Max # of wrestlers"/><br>
        <DropDown
          v-bind:options="bracketTypes"
          v-model="bracketType"
          label="Bracket Type"
        />
      </div>

      <div v-show="currentStep === 4">
        <DatePicker
          title="registrationStart"
          v-model="registration.entryOpenDate"
        /><span> ^^^^ Select Registration Date: {{registration.entryOpenDate?.toHTTP()}}</span><br>

        <InputField v-model="registration.entryFee" label="Entry Fee $$"/><br>
        <InputField v-model="registration.inviteOnly" label="Invite Only?"/><br>
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
import bent from 'bent'
import {DateTime} from 'luxon'
import {reactive, computed, toRefs, ref } from 'vue'
import {bracketTypes} from '../helpers/constants'

export default {
  setup() {
    const tournament = reactive({
      eventName      : "",
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

    const addTournament = async function () {
      console.log("Adding Tournament")
      let putRequest = bent('http://localhost:8081/', 'PUT', 'json')
      let response = await putRequest('tournaments', tournament)
      console.log("Response: ", response)
    }

    const currentStep = ref(1)

    const canGoBack    = computed(() => currentStep.value > 1)
    const canGoForward = computed(() => currentStep.value < 5)

    const goForward = () => {currentStep.value++}
    const goBack    = () => {currentStep.value--}

    return {...toRefs(tournament),bracketTypes, addTournament, currentStep, canGoBack, canGoForward, goForward, goBack}
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