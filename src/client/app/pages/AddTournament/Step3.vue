<template>
  <div>
    <!-- <InputField v-model="step3.numberOfMats" label="# of Mats"/>
    <InputField v-model="step3.minWrestlers" label="Min # of Wrestlers"/>
    <InputField v-model="step3.maxWrestlers" label="Max # of wrestlers"/> -->
    <!-- <DropDown
      v-bind:options="bracketTypes"
      v-model="bracketType"
      label="Bracket Type"
    /> -->
    {{step3}}
  </div>
</template>

<script>
import { computed } from 'vue'
export default {
  props: {
    modelValue: Object,
  },
  setup(props, {emit}) {
    const step3 = computed({
      get: () => props.modelValue,
      set: (data) => emit('update:modelValue', data)
    })
    console.log("step3 value: ",step3.value)
    return {step3}
  }
}
</script>

<style>

</style>