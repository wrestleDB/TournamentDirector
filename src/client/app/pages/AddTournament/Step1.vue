<template>
  <div>
    <InputField v-model="step1.eventName" label="Tournament Name"/>
    <hr>

    <DatePicker
      label="Start Date"
      v-model="step1.eventDate.startDate"
    />
    <hr>
    <Checkbox
      v-model="step1.inviteOnly"
      label="Invite Only?"
    />

    <hr>

    <InputField v-model="step1.entryFee" label="Entry Fee"/>
    <hr>
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