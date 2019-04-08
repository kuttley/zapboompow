<template>
  <div id="app">
    <div id="nav" class="container-fluid align-items-center">
      <div class="row justify-content-between">
        <router-link to="/" id="logo" class="col col-sm-auto h2">TEMPORARY</router-link>
        <div class="col col-sm-auto">
          <router-link to="/register">Register</router-link> |
          <router-link to="/login">Login</router-link>
        </div>
      </div>
    </div>
    <router-view/>
  </div>
</template>

<script>
import './assets/fonts.css';
export default {
  
}
</script>


<style lang="scss">
#app {
  font-family: 'YanoneKaffeesatz', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
}
#nav {
  padding: 30px;
  a {
    font-weight: bold;
    color: #2c3e50;
    &.router-link-exact-active {
      color: #42b983;
    }
  }
  #logo {
    color: #c97296;
    text-decoration: none;
  }
}
</style>
