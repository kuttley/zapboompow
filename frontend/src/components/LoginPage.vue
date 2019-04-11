<template>
    <div id="login" class="text-center">
        <h2>Login</h2>
        <form @submit.prevent="login" class="pt-3 pb-3 rounded">
            <div class="alert alert-danger" role="alert" v-if="invalidCredentials">
                Invalid username and password!
            </div>
            <div class="alert alert-success" role="alert" v-if="this.$route.query.registration">
                Thank you for registering, please sign in.
            </div>
            <label for="username" class="sr-only">Username</label>
            <input
                type="text"
                id="username"
                class="form-control"
                placeholder="Username"
                v-model="user.username"
                required
                autofocus
            />
            <label for="password" class="sr-only">Password</label>
            <input
                type="password"
                id="password"
                class="form-control"
                placeholder="Password"
                v-model="user.password"
                required
            />
            <div id="submittal" class="row justify-content-center">
                <div class="col col-sm-auto align-self-center">
                    <router-link :to="{ name: 'register' }">
                        Need an account?
                    </router-link>
                </div>
                <div class="col col-sm-auto">
                    <button class="btn btn-lg btn-primary btn-block" type="submit">
                        Sign in
                    </button>
                </div>
            </div>
        </form>
    </div>
</template>

<script>
import auth from '../auth';

export default {
  name: 'login',
  components: {},
  data() {
    return {
      user: {
        username: '',
        password: '',
      },
      invalidCredentials: false,
    };
  },
  methods: {
    login() {
      fetch(`${process.env.VUE_APP_REMOTE_API}/login`, {
        method: 'POST',
        headers: {
          Accept: 'application/json',
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(this.user),
      })
        .then((response) => {
          if (response.ok) {
            return response.text();
          } else {
            this.invalidCredentials = true;
          }
        })
        .then((token) => {
          if (token != undefined) {
            if (token.includes('"')) {
              token = token.replace(/"/g, '');
            }
            auth.saveToken(token);
            this.$router.push('/');
          }
        })
        .catch((err) => console.log(err));
    },
  },
};
</script>

<style lang="scss" scoped>
#login {
    background-color: rgba(255, 255, 255, 0.4);
}
h2, form, #submittal, #submittal div {
    background-color: rgba(255, 255, 255, 0);
}
form {
    padding-left: 25%;
    padding-right: 25%;

    input {
        margin-bottom: 10px;
    }
    input:last-item {
        margin-bottom: inherit;
    }
}
</style>

