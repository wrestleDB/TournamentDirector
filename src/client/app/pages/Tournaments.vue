<template>
  <div>
    <h1>List of Tournaments</h1>
    <template v-if="!isLoading">

      <EventCard v-for="event in events"
        :key="event.id"
        :event="event"
        @click="goToMatchPage(event.id)"/>

    </template>
    <p v-else>
      Loading events
    </p>
  </div>
</template>

<script>
import {useRouter} from 'vue-router'
import axios from 'axios'
import EventCard from '../components/EventCard.vue'

export default {
  setup(props, context){
    const router = useRouter()
    const goToMatchPage = (eventId) => {
      router.push({name: 'event-page', params: {id: eventId}})
    }
    return {goToMatchPage}
  },
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
