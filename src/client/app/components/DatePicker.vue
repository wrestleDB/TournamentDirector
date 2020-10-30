<template>
  <div id="date-picker">
    <br/>
    <p>one{{startDate}}</p>
    <p>two{{endDate}}</p>
    <p>Days: {{days}}</p>
    <!-- <p>Tournament starts: {{tournamentStart.value}} Tournament Ends: {{tournamentEnd || "___"}}</p> -->

    Title: {{title}}
    <br/>
    <div @click="openDatePicker()">
      <i class="fad fa-calendar-week"></i>
      <input placeholder="Select Dates"/>
    </div>

  </div>
</template>

<script>
import {reactive, computed, toRefs } from 'vue'
import { mapGetters, mapActions }  from 'vuex'
import { DateTime } from 'luxon'
import DatePickk from 'datepickk'

export default {
  props: {
    title: String
  },
  setup() {
    const datePicker = new DatePickk()

    datePicker.minDate       = DateTime.local().minus({months:1})
    datePicker.maxDate       = DateTime.local().plus({years:1})
    datePicker.months        = 1 // number of months to show at a time
    datePicker.title         = "Tournament Start"
    datePicker.button        = "Select"
    datePicker.lang          = "en"
    datePicker.range         = true // For Date Range, false for single date

    datePicker.onConfirm = function() {
      dateSet.startDate = DateTime.fromJSDate(this.selectedDates[0])
      dateSet.endDate = DateTime.fromJSDate(this.selectedDates[1])
    }

    const dateSet = reactive({
      startDate: DateTime.local(),
      endDate  : DateTime.local().plus({days:1}),
      days     : computed(() => {return dateSet.endDate.diff(dateSet.startDate, 'days').toObject().days})
    })


    function openDatePicker(){ datePicker.show() }

    return {...toRefs(dateSet), openDatePicker}
  },
  methods: {
    ...mapActions(['addEventDate']),
    setStartDate(date) {
      console.log("props:", this.$props.title)
      let dateInformation = {
        name: this.$props.title,
        type: 'start',
        date: date
      }
      this.addEventDate(dateInformation)
    },
    setEndDate() {
      console.log("props")
    }
  },
  watch: {
    startDate: function (to, from) {
      console.log("before: ", before.toHTTP())
      console.log("after: ", after.toHTTP())
      this.setStartDate(to)
    },
    endDate: function (to, from) {
      this.setEndDate(to)
    }

  }
}


// export default {
//   name: 'datePicker',
//   computed: {
//     tournamentStartDate: function (){
//       console.log("TournamentStartDate: ", this.datePicker.startDate)
//       return this.datePicker.startDate
//     },
//     selectedDates: function (){
//       console.log('this.selectedDates', this.datePicker.selectedDates)
//       return this.datePicker.selectedDates
//     }
//   },
//   methods: {
//     toggleCalendar() {
//       this.datePicker.show()

//       // if (this.isActive) {
//       //   console.log("IF STATEMENT")
//       //   this.datePicker.show({today:false})
//       // } else {
//       //   console.log("ELSE STATEMENT")
//       //   this.datePicker.hide()
//       // }
//       // this.isActive = !this.isActive
//       // return
//     }
//   },
//   data() {
//     return {
//       currentTime: DateTime.local(),
//       isActive: false,
//       tournamentStart: new Date(),
//       tournamentEnd: new Date(),
//       datePicker: datePicker
//     }
//   },
//   watch: {
//     datePicker: function (oldDates, newDates) {
//       console.log("OldDates: ", oldDates)
//       console.log("newDates: ", newDates)
//     }
//   }
// }

</script>

<style>

</style>