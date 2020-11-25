<template>
  <div>
    <h1>Event Page </h1>
    <p>Data here: {{event}}</p>
  </div>
</template>

<script>
import axios from 'axios'
import {ref} from 'vue'

export default {
  setup(props, context) {
    console.log("SETUP - event page props, context: ", {props, context})
    const event = ref({})
    return {event}
  },
  async created() {
    console.log("CREATED - route params: ", this.$route.params)
    const result = await axios.get(`/api/event/${this.$route.params?.id}`)
    console.log("THE RESPONSE", {result})
    this.event = result.data
  }
}
</script>

<style>

</style>