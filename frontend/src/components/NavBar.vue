<template>
    <div id="nav" class="container-fluid align-items-center rounded">
        <div class="row justify-content-between">
            <router-link to="/" id="logo" class="col col-sm-auto h1">TEMPORARY</router-link>
            <div v-if="userLoggedIn()" class="col col-sm-auto">
                <router-link to="/user">Hi, {{username}}</router-link> | 
                <router-link v-on:click.native="logout" to="/login">Logout</router-link>
            </div>
            <div v-else class="col col-sm-auto">
                <router-link to="/register">Register</router-link> | 
                <router-link to="/login">Login</router-link>
            </div>
        </div>
        <router-view />
    </div>
</template>

<script>
import auth from '@/auth';

export default {
    data() {
        return {
            username: '',
            userID: '',
        }
    },
    methods: {
        logout() {
            auth.logout();
            this.$router.push('/login');
        },
        userLoggedIn() {
            let user = auth.getUser();
            if (auth.getUser() != null) {
                this.username = user.sub;
                return true;
            } else
                return false;
        }
    }
}
</script>

<style lang="scss" scoped>
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

