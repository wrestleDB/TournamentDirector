<template>
  <div class="date-picker">
    <i class="fad fa-calendar-week fa-2x" @click="openDatePicker()"></i>
    <!-- <input @click="openDatePicker()" placeholder="Select Dates" /> -->
  </div>
</template>

<script>
import { computed } from 'vue'
import { DateTime } from 'luxon'
import DatePickk from 'datepickk'

// import {useModelWrapper} from '../helpers/modelWrapper'

const datePicker = new DatePickk({
  minDate       : DateTime.local().minus({months:1}),
  maxDate       : DateTime.local().plus({years:1}),
  maxSelections : 1, // Max number of selected Dates
  months        : 1, // number of months to show at a time
  title         : "Tournament Start",
  button        : "Select"
})

export default {
  props: {
    title: String,
    modelValue: Object,
  },
  setup(props, {emit}) {

    const selectedStartDate = computed({
      get: () => props.modelValue,
      set: (date) => emit('update:modelValue', date)
    })


    datePicker.onConfirm = function() {
      selectedStartDate.value = DateTime.fromJSDate(this.selectedDates[0])
      // dateSet.endDate = DateTime.fromJSDate(this.selectedDates[0])
      // dateSet.endDate = DateTime.fromJSDate(this.selectedDates.slice(-1))
    }

    function openDatePicker(){ datePicker.show() }

    return {openDatePicker, selectedStartDate}
  }
}
</script>

<style>

</style>