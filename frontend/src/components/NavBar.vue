<template>
    <div id="nav" class="container-fluid align-items-center rounded-bottom shadow">
        <div class="row justify-content-between" height="200px">
            <router-link to="/" id="logo" class="col col-sm-auto h1"><img src="@/assets/logo.png" width="100px" alt="zapboompow"></router-link>
                      <form method="GET" class="form-inline" v-on:submit.prevent="getComics">

                  <v-text-field
                  label="Search For Comic By Name"
                  solo-inverted v-model="searchComicName">
                  </v-text-field>
                  <v-text-field
                  label="Issue Number"
                  append-icon="search"
                  solo-inverted v-model="searchIssueNumber">
                  </v-text-field>
            <v-btn color="primary" flat :to="'/search'" name="submit" value="Search" type="submit">Submit</v-btn>
                      </form>

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

