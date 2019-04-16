<template>
    <div id="nav" class="container-fluid align-items-center rounded-bottom shadow">
        <div class="row justify-content-between" height="200px">
          <router-link to="/" id="logo" class="col col-sm-auto h1"><img src="@/assets/logo.png" width="100px" alt="zapboompow"></router-link>
          <div class="col col-sm-auto align-self-center">
            <form method="GET" class="form-inline">
              <div class="row align-self-center">
              <v-text-field label="Search For Comic By Name" solo-inverted v-model="searchComicName" v-on:keyup.enter="searchSubmit"></v-text-field>
              <v-text-field label="Issue Number" append-icon="search" solo-inverted v-model="searchIssueNumber" v-on:keyup.enter="searchSubmit"></v-text-field>
              <v-btn color="primary white--text" class="text-none" dark :to="{ name:'search', query: { 'title': searchComicName,  'issueNumber': searchIssueNumber} }" name='submit' type='search' value="Search">Submit</v-btn>
              </div>
            </form>
          </div>
          <div v-if="loggedIn" class="col col-sm-auto align-self-end mb-3 mr-3 d-flex flex-column">
            <v-btn to="/collections/create" color="primary white--text" class="text-none" small dark>Create Collection</v-btn>
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
            this.$emit('logout');
        },
        searchSubmit() { 
          this.$router.push({ name:'search', query: { 'title': this.searchComicName,  'issueNumber': this.searchIssueNumber} });
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

