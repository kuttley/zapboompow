<template>
    <div id="nav" class="container-fluid align-items-center rounded-bottom shadow">
        <div class="row justify-content-between" height="200px">
          <router-link to="/" id="logo" class="col col-sm-auto h1"><img src="@/assets/logo.png" width="100px" alt="zapboompow"></router-link>
          <div class="col col-sm-auto align-self-center">
            <form method="GET" class="form-inline">
              <div class="row align-self-center">
                <v-text-field label="Search By Title" hide-details solo-inverted v-model="searchComicName" v-on:keyup.enter="searchSubmit"></v-text-field>
                <v-text-field label="Search By Issue Number" append-icon="search" hide-details solo-inverted v-model="searchIssueNumber" v-on:keyup.enter="searchSubmit"></v-text-field>
                <v-btn small color="mt-2 primary white--text" class="text-none" dark :to="{ name:'search', query: { 'title': searchComicName,  'issueNumber': searchIssueNumber} }" name='submit' type='search' value="Search">Search</v-btn>
              </div>
            </form>
          </div>
          <div v-if="loggedIn" class="col col-sm-auto align-self-end mb-3 mr-2 d-flex flex-column text-center">
            <v-btn to="/collections/create" color="primary white--text" class="text-none" small dark>Create Collection<v-icon class="ml-1">create_new_folder</v-icon></v-btn>
            <div>
              <router-link :to="`/user/${this.userID}`">Hi, {{this.username}}</router-link> | 
              <router-link v-on:click.native="logout" to="/login">Logout</router-link>
            </div>
          </div>
          <div v-else class="col col-sm-auto align-self-end mb-3 mr-3">
              <router-link to="/register">Register</router-link> | 
              <router-link to="/login">Login</router-link>
          </div>
        </div>
    </div>
</template>

<script>
import apiCalls from '@/apiCalls';

export default {
    props: {
        loggedIn: Boolean,
        username: String,
        userID: Number,
    },
    data() {
      return {
        searchComicName: '',
        searchIssueNumber: ''
      }
    },
    methods: {
        logout() {
          apiCalls.post('/logout');
          this.$emit('logout');
        },
        searchSubmit() { 
          this.$router.push({ name:'search', query: { 'title': this.searchComicName,  'issueNumber': this.searchIssueNumber} });
          this.searchComicName = '';
          this.searchIssueNumber = '';
        },
    }
}
</script>

<style lang="scss" scoped>
#nav {
  margin-bottom: 15px;
  background-color: rgb(193, 225, 231);
  color: #21272d;
  a {
    font-weight: normal;
    text-decoration: none;
    color: #445a7c;
    font-size: 1.5em;
    &:hover {
      color: #b6b6b6;
    }
  }
  #logo {
    color: #f7d281;
    font-size: 3em;
    text-decoration: none;
  }

  .v-btn {
    font-size: 1.3em;
  }
}
</style>

