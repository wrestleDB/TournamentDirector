<template>
  <div>
    <h1>List of My wrestlers</h1>
    <div class="list-of-my-wrestlers">
      <div class="wrestler"
        v-for="(wrestler, index) in allWrestlers"
        v-bind:item="wrestler"
        v-bind:index="index"
        v-bind:key="wrestler._id"
      >
        <p class="text">{{ wrestler.name }}</p>
      </div>
    </div>
  </div>
</template>

<script lang="coffee">
import { mapGetters, mapActions }  from 'vuex'

export default {
  name     : "MyWrestlersPage"
  computed : mapGetters(['allWrestlers'])
  methods  : mapActions(['getWrestlers'])
  created  : -> await this.getWrestlers()
  data     : -> return {}
}
</script>

<style>

</style>