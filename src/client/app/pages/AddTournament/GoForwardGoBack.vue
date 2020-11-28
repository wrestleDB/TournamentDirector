<template>
  <div>
    <button v-if="canGoBack" @click="goBack"><i class="fad fa-arrow-to-left"></i> Go Back</button>
    <button v-else disabled hidden> Start</button>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Current Step:&nbsp;{{currentStep}}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <button v-if="canGoForward" @click="goForward"> Next Step <i class="fad fa-arrow-to-right"></i></button>
    <button v-else disabled hidden> End </button>
  </div>
</template>

<script>
import { computed } from 'vue'

export default {
  props: {
    modelValue: Number
  },
  setup(props, {emit}) {

    const currentStep = computed({
      get: () => props.modelValue,
      set: (stepCount) => emit('update:modelValue', stepCount)
    })
    const canGoBack    = computed(() => currentStep.value > 1)
    const canGoForward = computed(() => currentStep.value < 5)

    const goForward = () => {currentStep.value++}
    const goBack    = () => {currentStep.value--}

    return {currentStep, canGoBack, canGoForward, goForward, goBack}
  }
}
</script>

<style>

</style>