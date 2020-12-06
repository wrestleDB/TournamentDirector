<template>
  <div>
    <!-- <InputField v-model="step4.numberOfMats" label="# of Mats"/>
    <InputField v-model="step4.minWrestlers" label="Min # of Wrestlers"/>
    <InputField v-model="step4.maxWrestlers" label="Max # of wrestlers"/> -->
    <!-- <DropDown
      v-bind:options="bracketTypes"
      v-model="bracketType"
      label="Bracket Type"
    /> -->
    {{step4}}
  </div>
</template>

<script>
import { computed } from 'vue'
export default {
  props: {
    modelValue: Object,
  },
  setup(props, {emit}) {
    const step4 = computed({
      get: () => props.modelValue,
      set: (data) => emit('update:modelValue', data)
    })
    console.log("step4 value: ",step4.value)
    return {step4}
  }
}
</script>

<style>

</style>