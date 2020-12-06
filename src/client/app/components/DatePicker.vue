<template>
  <label v-if="label">{{ label }}: </label>
  <div class="input-icons" @click="openDatePicker()">
    <i class="fad fa-calendar-week fa-2x icon"></i>
    <input class="input-field" type="text" v-bind:value="formattedDate">
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
  // button        : "Select",
  closeOnSelect : true
})

export default {
  props: {
    label: String,
    modelValue: Object,
  },
  setup(props, {emit}) {

    const selectedStartDate = computed({
      get: () => props.modelValue,
      set: (date) => emit('update:modelValue', date)
    })

    const formattedDate = computed({
      get: () => `            ${selectedStartDate.value || "MM/DD/YYYY"}`
    })

    datePicker.onClose = function() { // change this to onSelect if utilizing the close button instead of closeOnSelect
      selectedStartDate.value = DateTime.fromJSDate(this.selectedDates[0])
      // dateSet.endDate = DateTime.fromJSDate(this.selectedDates[0])
      // dateSet.endDate = DateTime.fromJSDate(this.selectedDates.slice(-1))
    }

    function openDatePicker(){ datePicker.show() }

    return {openDatePicker, selectedStartDate, formattedDate}
  }
}
</script>

<style scoped>
.input-icons i {
  position: absolute;
}
.input-icons {
  width: 100%;
  margin-bottom: 10px;
}
.icon {
  padding: 10px;
  color: green;
  min-width: 50px;
  text-align: center;
}
.input-field {
  width: 100%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
}

</style>
