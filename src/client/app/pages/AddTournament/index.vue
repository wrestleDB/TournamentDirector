<template>
  <div id="add-tournament">
    <h1>
      <i class="fad fa-home-lg"></i> Add Tournament
    </h1>
    <ProgressTracker v-model="currentStep"/>
    <br><hr>
    <div class="regcard">
      <div v-show="currentStep === 1"><Step1 v-model="step1"/></div>
      <!-- <div v-show="currentStep === 11">
        <InputField v-model="eventName" label="Tournament Name"/>
        <br>
        <DatePicker
          title="tournamentStart"
          v-model="eventDate.startDate"
        /><span> ^^^^ Select Start Date: {{eventDate.startDate?.toHTTP()}}</span>
      </div> -->

      <div v-show="currentStep === 2">
        <InputField v-model="location.address" label="Address"/><br>
        <InputField v-model="location.postalCode" label="Postal Code"/><br>
        <InputField v-model="location.city" label="City"/><br>
        <InputField v-model="location.state" label="State"/><br>
      </div>

      <div v-show="currentStep === 3">
        <InputField v-model="registration.numberOfMats" label="# of Mats"/>
        <InputField v-model="registration.minWrestlers" label="Min # of Wrestlers"/>
        <InputField v-model="registration.maxWrestlers" label="Max # of wrestlers"/>
        <DropDown
          v-bind:options="bracketTypes"
          v-model="bracketType"
          label="Bracket Type"
        />
      </div>

      <div v-show="currentStep === 4">
        <p> Select Registration Open Date: {{registration.entryOpenDate?.toHTTP()}}
        <DatePicker
          title="registrationStart"
          v-model="registration.entryOpenDate"
        /></p><p>
        Select Registration Close Date: {{registration.entryCloseDate?.toHTTP()}}
        <DatePicker
          title="registrationEnd"
          v-model="registration.entryCloseDate"
        /></p>
        <div>
					<label>Registration Start:</label>
					<input type="date" name="registrationStart" class="dateinput">
          <label>Registration End:</label>
					<input type="date" name="registrationEnd" class="dateinput">
				</div> <br>
        <InputField v-model="registration.entryFee" label="Entry Fee $$"/><br>
        <InputField v-model="registration.inviteOnly" label="Invite Only?"/><br>
      </div>

      <div v-show="currentStep === 5">
        <h1>Summary:</h1>
        <p>Step1: {{step1}}</p>
        <p>Event Name: {{eventName}}</p>
        <p>Bracket Type: {{bracketType}}</p>
        <p>Number Of Mats: {{numberOfMats}}</p><br>
        <p>Event Date: {{eventDate}}</p>
        <p>Location: {{location}}</p>
        <p>registration: {{registration}}</p>
        <button @click="addTournament()">Create Tournament</button>
      </div>
    </div>
    <hr>
    <GoForwardGoBack v-model="currentStep"/>
    <hr>
  </div>
</template>

<script>
import axios from 'axios'
import {DateTime} from 'luxon'
import {reactive, computed, toRefs, ref } from 'vue'
import {useRouter} from 'vue-router'
import {bracketTypes} from '../../../helpers/constants'

import ProgressTracker from './ProgressTracker.vue'
import GoForwardGoBack from './GoForwardGoBack.vue'
import Step1 from './Step1.vue'
import Step2 from './Step2.vue'
import Step3 from './Step3.vue'
import Step4 from './Step4.vue'

const router = useRouter()

export default {
  components: {
    ProgressTracker,
    GoForwardGoBack,
    Step1,
    Step2,
    Step3,
    Step4
  },
  setup() {
    const currentStep = ref(1)
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
        numberOfMats   : "", // Optional, should be able to set later.
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

    const tournamentData = reactive({
      step1: { // Name & Date
        eventName: "",
        eventDate: {
          startDate: null,
          endDate  : null,
        },
        inviteOnly: false,
        entryFee: 0
      },
      step2: { // Location
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
      step3: { // Registration
        numberOfMats   : "", // Optional, should be able to set later.
        entryFee       : "",
        inviteOnly     : "",
        openDate       : "",
        closeDate      : "",
        minWrestlers   : "",
        maxWrestlers   : "",
        earlyDiscount  : "",
        earlyOpenDate  : "",
        earlyCloseDate : ""
      },
      step4: { // Set Divisions (weights, age groups, gender, etc.)
        divisions: [] //Handle this logic in the divisions component, bunch of strings
      }

    })

    const addTournament = async function () {
      console.log("Adding Tournament")
      axios.post('api/tournaments', tournament)
        .then((response) => {
          console.log(response.data)
          if (response.data?.error) console.log("ERROR: ", response.data.error?.message)
          else router.push({name: 'all-tournaments'})
        })
        .catch((error) => {
          console.log("cauht an error: ", {error})
        }
      )
    }

    return {...toRefs(tournament), ...toRefs(tournamentData), bracketTypes, addTournament, currentStep}
  }
}
</script>

<style scoped>
#add-tournament {
  margin-left: 50%;
  transform: translateX(-50%);
  text-align: right;
  padding: 10;
  border-radius: 1px;
  /* display: inline-block; */
  background-color: #f2f2f2;
  box-shadow: 5px 10px 2em #888888;
  align-self: center;
}

.regcard {
  width: 90%;
  min-height: 350;
  text-align: left;
  padding: 20;
  border-radius: 5px;
  background-color: #f2f2f2;
}

</style>