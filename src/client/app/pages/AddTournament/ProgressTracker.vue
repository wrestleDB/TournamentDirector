<template>
  <div class="container-progressbar">
    <ul class="progressbar">
      <li v-bind:class="{active: modelValue > 0}">Name/Date</li>
      <li v-bind:class="{active: modelValue > 1}">Location</li>
      <li v-bind:class="{active: modelValue > 2}">Details</li>
      <li v-bind:class="{active: modelValue > 3}">Registration</li>
      <li v-bind:class="{active: modelValue > 4}">Finished</li>
    </ul>
  </div>
</template>

<script>
export default {
  props: {
    modelValue: Number
  }
}
</script>

<style>
  .container-progressbar {
    width: 100%;
    margin: auto;
    padding-bottom: 50;
  }
  .progressbar {
    counter-reset: step 0;
  }
  .progressbar li {
    list-style-type: none;
    width: 20%;
    float: left;
    font-size: 14px;
    position: relative;
    text-align: center;
    text-transform: uppercase;
    color: #363636;
  }
  .progressbar li:before {
    width: 30px;
    height: 30px;
    content: counter(step);
    counter-increment: step;
    line-height: 30px;
    border: 4px solid #6d6d6d;
    display: block;
    text-align: center;
    margin: 0 auto 10px auto;
    border-radius: 50%;
    background-color: white;
  }
  .progressbar li:after {
    width: 100%;
    height: 10px;
    content: '';
    position: absolute;
    background-color: #6d6d6d;
    top: 15px;
    left: -50%;
    z-index: -1;
  }
  .progressbar li:first-child:after {
    content: none;
  }
  .progressbar li.active {
    color: #363636;
  }
  .progressbar li.active:before {
    border-color: #1bb630;
    background-color: #fafafa
  }
  .progressbar li.active:after {
    background-color: #1bb630;
    transition-timing-function: linear;
  }
</style>