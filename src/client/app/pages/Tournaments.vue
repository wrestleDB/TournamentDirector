<template>
  <div>
    <h1>List of Tournaments</h1>
    <template v-if="!isLoading">
      <!-- TODO: Each eventCard should be a link to the tournament landing page. -->
      <EventCard v-for="event in events" :key="event.id" :event="event" />
    </template>
    <p v-else>
      Loading events
    </p>
  </div>
</template>

<script>
import axios from 'axios'
import EventCard from '../components/EventCard.vue'

export default {
  components: { EventCard },
  data () {
    return {
      isLoading: true,
      events: []
    }
  },
  async created () {
    const result = await axios.get('api/tournaments')
    console.log("Here; data", result.data)
    this.events = result.data
    this.isLoading = false
  }
}
</script>
