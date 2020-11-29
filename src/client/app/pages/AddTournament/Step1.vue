<template>
  <div>
    <InputField v-model="step1.eventName" label="Tournament Name"/>
    <br>
    <DatePicker
      title="tournamentStart"
      v-model="step1.startDate"
    /><span> ^^^^ Select Start Date: {{step1.startDate?.toHTTP()}}</span>
    {{step1}}
  </div>
</template>

<script>
import { computed } from 'vue'
export default {
  props: {
    modelValue: Object,
  },
  setup(props, {emit}) {
    const step1 = computed({
      get: () => props.modelValue,
      set: (data) => emit('update:modelValue', data)
    })
    console.log("STep1 value: ",step1.value)
    return {step1}
  }
}
</script>

<style>

</style>