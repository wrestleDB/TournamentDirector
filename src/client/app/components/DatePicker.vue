<template>
  <div id="date-picker">
    HERE: -->{{tournamentStartDate}}
    SelectedDates: {{selectedDates}}
    <p>Tournament starts: {{tournamentStart || "___"}} Tournament Ends: {{tournamentEnd || "___"}}</p>

    <input v-model="tournamentStart" placeholder="Registration Opens" @click="toggleCalendar()" />


  </div>
</template>

<script>
import { DateTime } from 'luxon'
import DatePickk from 'datepickk'

const datePicker = new DatePickk()


datePicker.startDate     = DateTime.local()
datePicker.minDate       = DateTime.local().minus({months:1})
datePicker.maxDate       = DateTime.local().plus({years:1})
datePicker.currentDate   = DateTime.local()
datePicker.maxSelections = 1 // Max number of selected Dates
datePicker.months        = 1 // number of months to show at a time
datePicker.title         = "Tournament Start"
datePicker.button        = "Select"
// datePicker.lang          = ""
// datePicker.weekStart     = ""
datePicker.range         = true // For Date Range, false for single date
// datePicker.container     = ""
datePicker.inline        = false // Disables the need to show/hide
datePicker.closeOnSelect = false // Disable this for Date Range
// datePicker.closeOnClick  = ""
// datePicker.tooltips      = ""
// datePicker.highlight     = ""
// datePicker.disabledDays  = ""
// datePicker.disabledDates = ""
// datePicker.today         = ""
// datePicker.daynames      = ""
// datePicker.fullscreen    = ""
// datePicker.locked        = ""

datePicker.onConfirm = function(){
  alert("onConfirm")
}


export default {
  name: 'datePicker',
  computed: {
    tournamentStartDate: function (){
      console.log("TournamentStartDate: ", this.datePicker.startDate)
      return this.datePicker.startDate
    },
    selectedDates: function (){
      console.log('this.selectedDates', this.datePicker.selectedDates)
      return this.datePicker.selectedDates
    }
  },
  methods: {
    toggleCalendar() {
      this.datePicker.show()

      // if (this.isActive) {
      //   console.log("IF STATEMENT")
      //   this.datePicker.show({today:false})
      // } else {
      //   console.log("ELSE STATEMENT")
      //   this.datePicker.hide()
      // }
      // this.isActive = !this.isActive
      // return
    }
  },
  data() {
    return {
      currentTime: DateTime.local(),
      isActive: false,
      tournamentStart: new Date(),
      tournamentEnd: new Date(),
      datePicker: datePicker
    }
  },
  watch: {
    datePicker: function (oldDates, newDates) {
      console.log("OldDates: ", oldDates)
      console.log("newDates: ", newDates)
    }
  }
}
</script>

<style>

</style>