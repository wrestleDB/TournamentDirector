<template>
  <div>
    <h1>List of My wrestlers</h1>
    <li>Wrestler 1</li>
    <li>Wrestler 2</li>
    <li>Wrestler 3</li>
    <div class="list-of-my-wrestlers">
      <div class="wrestler"
        v-for="(wrestler, index) in wrestlers"
        v-bind:item="wrestler"
        v-bind:index="index"
        v-bind:key="wrestler._id"
      >
        <p class="text">{{ wrestler.name }}</p>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters, mapActions }  from 'vuex'

export default {
  name     : "MyWrestlersPage",
  // computed : mapGetters(['allWrestlers']),
  // methods  : mapActions(['getWrestlers']),
  // created  : async () => await this.getWrestlers(),
  data : () => {
    return {
      wrestlers: [{
      _id: "111",
      name: "wrestler Adam"
    }, {
      _id: "112",
      name: "wrestler Eve"
    }]
    }
  }
}
</script>

<style>

</style>