<template>
  <div>
    <InputField v-model="step2.address" label="Address"/><br>
    <InputField v-model="step2.postalCode" label="Postal Code"/><br>
    <InputField v-model="step2.city" label="City"/><br>
    <InputField v-model="step2.state" label="State"/><br>
    {{step2}}
  </div>
</template>

<script>
import { computed } from 'vue'
export default {
  props: {
    modelValue: Object,
  },
  setup(props, {emit}) {
    const step2 = computed({
      get: () => props.modelValue,
      set: (data) => emit('update:modelValue', data)
    })
    console.log("STep2 value: ",step2.value)
    return {step2}
  }
}
</script>

<style>

</style>