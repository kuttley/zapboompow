<template>
  <v-app>
    <nav-bar :loggedIn="loggedIn" :username="username" :userID="userID" v-on:logout="userLogout" />

    <router-view :key="$route.fullPath" />

    <v-footer style="background-color: rgba(255,255,255,0)"><v-spacer></v-spacer><a href="http://marvel.com" class="black--text">Data provided by Marvel. © 2019 Marvel</a></v-footer>
  </v-app>
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
      this.username = '';
      this.userId = 0;
      this.loggedIn = false;
      this.$router.push('/login');
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
  background-color: #F9EBBC;
  background-image: url('./assets/comicbackground.png');
  background-position: center;
  background-size: contain;
  font-family: 'YanoneKaffeesatz', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #21272d;
  padding-right: 10%;
  padding-left: 10%;
}
</style>
