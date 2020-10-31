<template>
  <div id="date-picker">
    <br/>
    <p>one{{tournamentStartDate}}</p>
    <p>two{{tournamentEndDate}}</p>
    <p>Days: {{days}}</p>
    <p>test: {{tournamentStartDate}}</p>
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

const datePicker = new DatePickk()
datePicker.minDate = DateTime.local().minus({months:1})
datePicker.maxDate = DateTime.local().plus({years:1})
datePicker.months  = 1 // number of months to show at a time
datePicker.title   += "Tournament Start"
datePicker.button  = "Select"
datePicker.lang    = "en"
datePicker.range   = true // For Date Range, false for single date

export default {
  // props: {
  //   title: String
  // },
  props: ['title', 'tournamentDates'],
  context: {
    testing: "strataga"
  },
  setup(props, context) {
    console.log("props", JSON.stringify(props, null, 2))
    console.log("context", JSON.stringify(context, null, 2))

    const dateSet = reactive({
      [`${props.title}StartDate`]: DateTime.local(),
      [`${props.title}EndDate`]  : DateTime.local().plus({days:1}),
      days : computed(() => {return dateSet[`${props.title}EndDate`].diff(dateSet[`${props.title}StartDate`], 'days').toObject().days})
    })

    datePicker.onConfirm = function() {
      dateSet[`${props.title}StartDate`] = DateTime.fromJSDate(this.selectedDates[0])
      dateSet[`${props.title}EndDate`] = DateTime.fromJSDate(this.selectedDates[1])
    }

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