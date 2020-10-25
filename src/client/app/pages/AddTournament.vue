<template>
  <div id="add-tournament">
    <!-- <h1><i class="fad fa-home-lg"></i> Add Tournament{{currentTime}}</h1>
    <p><input v-model="tournament.eventName" placeholder="Tournament Name"/> Tournament name is: {{tournament.eventName || "___"}}</p>
    <p><input v-model="tournament.registration.numberOfMats" placeholder="Number of Mats"/> How Many Mats?  {{tournament.registration.numberOfMats || "___"}}</p>
    <p><input v-model="tournament.registration.minWrestlers" placeholder="Min # of Wrestlers"/> {{tournament.registration.minWrestlers || "___"}} Min # of Wrestlers</p>
    <p><input v-model="tournament.registration.maxWrestlers" placeholder="Max # of Wrestlers"/> {{tournament.registration.maxWrestlers || "___"}} Max # of Wrestlers</p>

    <DatePicker/>
    <p><input v-model="tournament.eventDate.startDate" placeholder="Start Date"/> Start Date? {{tournament.eventDate.startDate || "___"}} TODO: implement date picker</p>
    <p><input v-model="tournament.eventDate.endDate" placeholder="When"/> End Date? {{tournament.eventDate.endDate || "___"}} TODO: implement date picker</p>

    <p><input v-model="tournament.location.address" placeholder="Where"/> Where? {{tournament.location.address || "___"}} TODO: implement google maps</p>
    <p><input v-model="tournament.registration.entryFee" placeholder="How much $"/> Entry Fee Cost is ${{tournament.registration.entryFee || "___"}}</p>




    <p>Registration opens: {{tournament.registration.entryOpenDate || "___"}} Registration closes: {{tournament.registration.entryCloseDate || "___"}}</p>
    <p @click=selectDate>
      <input v-model="tournament.registration.entryOpenDate" placeholder="Registration Opens"/> to
      <input v-model="tournament.registration.entryCloseDate" placeholder="Registration Closes"/>
    </p>
    <p><input v-model="tournament.registration.inviteOnly" placeholder="Invite Only?"/> Invite only? {{tournament.registration.inviteOnly || "___"}} (meaning only certain teams can register)</p>
    <p><input v-model="tournament.bracketType" placeholder="double-elimination or round-robin"/> Bracket Type: {{tournament.bracketType || "___"}}, TODO: make this dropdown with additional params</p>
    <button @click="addTournament()">click this button</button> -->

    <DatePickerComposition id='tournamentstart'/>
  </div>
</template>

<script>
import { mapGetters, mapActions }  from 'vuex'
import { DateTime } from 'luxon'
import DatePicker from '../components/DatePicker.vue'
import DatePickerComposition from '../components/DatePickerComposition.vue'

export default {
  name: 'addTournamentPage',
  computed: mapGetters(['tournament', 'status']),
  methods: {
    ...mapActions(['addTournament', 'validateTournamentData']),
    getGoogleMapsAPI() {
      console.log("getGoogleAPI")
    }
  },
  data() {
    return {
      currentTime: DateTime.local(),
    }
  },
  components: {
    DatePicker,
    DatePickerComposition
  }
}
</script>

<style>

</style>