<template>
  <label v-if="label">{{ label }}: </label>
  <input
    v-bind="$attrs"
    v-bind:value="modelValue"
    v-bind:placeholder="label"
    @input="$emit('update:modelValue', $event.target.value)"
  >
</template>

<script>
export default {
  props: {
    label: {
      type: String,
      default: ''
    },
    modelValue: {
      type: [String, Number],
      default: ''
    }
  }
}
</script>