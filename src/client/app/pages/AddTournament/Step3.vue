<template>
  <div>
    <InputField v-model="step3.numberOfMats" label="Number of Mats"/>
    <InputField v-model="step3.entryFee" label="Entry Fee"/>
    <DatePicker
      label="Event Registration Opens"
      v-model="openDate"
    />
    <hr>
    <DatePicker
      label="Event Registration Closes"
      v-model="step3.closeDate"
    />
    <hr>
    <Checkbox
      v-model="step3.inviteOnly"
      label="Invite Only?"
    />
    {{step3}}
  </div>
</template>

<script>
import { computed } from 'vue'
export default {
  props: {
    modelValue: Object,
  },
  setup(props, context) {
    console.log("STEP 3",{context})
    const {emit} = context

    const step3 = computed({
      get: () => props.modelValue,
      set: (data) => emit('update:modelValue', data)
    })
    const openDate = computed({
      get: () => props.modelValue.openDate,
      set: (data) => emit('update:modelValue.openDate', data)
    })

    console.log("step3 value: ",JSON.stringify(step3.value.openDate))
    return {step3, openDate}
  }
}
</script>

<style>

</style>