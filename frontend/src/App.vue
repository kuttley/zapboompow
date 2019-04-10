<template>
  <div id="app">
    <nav-bar />

  </div>
</template>

<script>
import './assets/fonts.css';
import NavBar from '@/components/NavBar.vue';

export default {
  components: {
    NavBar
  },
  data() {
    return {

    }
  }
}
</script>


<style lang="scss">
* {
  background-color: #D1E2FD
}
#app {
  font-family: 'YanoneKaffeesatz', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
  padding-right: 10%;
  padding-left: 10%;
}
</style>
