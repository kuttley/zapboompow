<template>
    <div id="nav" class="container-fluid align-items-center rounded-bottom shadow">
        <div class="row justify-content-between" height="200px">
            <router-link to="/" id="logo" class="col col-sm-auto h1"><img src="@/assets/logo.png" width="100px" alt="zapboompow"></router-link>
            <div v-if="loggedIn" class="col col-sm-auto align-self-end mb-3 mr-3 d-flex flex-column">
              <router-link to="/collections/create" tag="button" class="btn btn-primary">Create Collection</router-link>
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
}
</style>

