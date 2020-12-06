<template>
  <div id="add-tournament">
    <h1>
      <i class="fad fa-home-lg"></i> Add Tournament
    </h1>
    <ProgressTracker v-model="currentStep"/>
    <br><hr>
    <div class="regcard">
      <div v-show="currentStep === 1">
        <Step1 v-model="step1"/>
      </div>

      <div v-show="currentStep === 2">
        <Step2 v-model="step2" />
      </div>

      <div v-show="currentStep === 3">
        <Step3 v-model="step3" />
      </div>

      <div v-show="currentStep === 4">
        <Step4 v-model="step4" />
      </div>

      <div v-show="currentStep === 5">
        <h1>Summary:</h1>
        <p>Step1: {{step1}}</p>
        <p>Step2: {{step2}}</p>
        <p>Step3: {{step3}}</p>
        <p>Step4: {{step4}}</p>
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
import {reactive, toRefs, ref } from 'vue'
import {useRouter} from 'vue-router'
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
        openDate       : {},
        closeDate      : {},
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

    const currentStep = ref(1)

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

    return {...toRefs(tournamentData), addTournament, currentStep}
  }
}
</script>

<style scoped>
.regcard {
  width: 90%;
  min-height: 350;
  text-align: left;
  padding: 20;
  border-radius: 5px;
  background-color: #f2f2f2;
}

</style>