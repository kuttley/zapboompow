<template>
  <div id="app">
    <nav-bar :loggedIn="loggedIn" :username="username" :userID="userID" v-on:logout="userLogout" />

    <router-view />
  </div>
</template>

<script>
import auth from '@/auth';
import './assets/fonts.css';
import NavBar from '@/components/NavBar.vue';

export default {
  components: {
    NavBar
  },
  created() {
    this.loggedIn = this.userLoggedIn();
  },
  updated() {
    this.loggedIn = this.userLoggedIn();
  },
  data() {
    return {
      username: '',
      userID: 0,
      loggedIn: false,
    }
  },
  methods: {
    userLogout() {
      auth.logout();
      this.$router.push('/login');
      this.username = '';
      this.userId = 0;
      this.loggedIn = false;
    },
    userLoggedIn() {
        let user = auth.getUser();
        if (auth.getUser() != null) {
            this.username = user.sub;
            this.userID = user.uid;
            return true;
        } else
            return false;
    }
  }
}
</script>


<style lang="scss" scoped>
#app {
  font-family: 'YanoneKaffeesatz', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
  padding-right: 10%;
  padding-left: 10%;
}
</style>
