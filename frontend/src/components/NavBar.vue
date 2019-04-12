<template>
    <div id="nav" class="container-fluid align-items-center rounded shadow-sm">
        <div class="row justify-content-between">
            <router-link to="/" id="logo" class="col col-sm-auto h1">TEMPORARY</router-link>
            <div v-if="loggedIn" class="col col-sm-auto d-flex flex-column">
              <div>
                <router-link :to="`/user/${this.userID}`">Hi, {{this.username}}</router-link> | 
                <router-link v-on:click.native="logout" to="/login">Logout</router-link>
              </div>
              <router-link to="/collections/create" tag="button" class="btn btn-primary">Create Collection</router-link>
            </div>
            <div v-else class="col col-sm-auto">
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
  padding: 30px;
  margin-bottom: 15px;
  background-color: rgba(255, 255, 255, 0.4);
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

