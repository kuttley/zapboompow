<template>
  <div id="app">
    <div id="nav" class="container-fluid align-items-center rounded">
      <div class="row justify-content-between">
        <router-link to="/" id="logo" class="col col-sm-auto h1">TEMPORARY</router-link>
        <div class="col col-sm-auto">
          <router-link to="/register" replace>Register</router-link> |
          <router-link to="/login" replace>Login</router-link>
          <router-link v-on:click.native="logout" to="/login">Logout</router-link>
        </div>
      </div>
    </div>

    <router-view />
  </div>
</template>

<script>
import './assets/fonts.css';
import auth from '@/auth';
export default {
  mounted() {
    if (auth.getUser() != null) {
      this.$router.replace();
    }
  },
  methods: {
    logout() {
      auth.logout();
      this.$router.push('/login');
      localStorage.authenticated = false;
    },
    setAuthenticated(status) {
      localStorage.authenticated = status;
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
#nav {
  padding: 30px;
  margin-bottom: 15px;
  background-color: rgba(255, 255, 255, 0.4);
  * {
    background-color: rgba(255, 255, 255, 0);
  }
  a {
    font-weight: bold;
    text-decoration: none;
    color: #79C5BE;
    font-size: 1.5em;
    &:hover {
      color: #8dc9ae;
    }
    &.router-link-exact-active {
      color: #7CB8C7;
    }
    &.router-link-exact-active:hover {
      color: #859cb4;
    }
  }
  #logo {
    color: #8190CC;
    font-size: 3em;
    text-decoration: none;
  }
}
</style>
