<template>
  <div>
    <InputField v-model="eventName" label="Tournament Name"/>
    <br>
    <DatePicker
      title="tournamentStart"
      v-model="eventDate.startDate"
    /><span> ^^^^ Select Start Date: {{eventDate.startDate?.toHTTP()}}</span>
  </div>
</template>

<script>
export default {

}
</script>

<style>

</style>