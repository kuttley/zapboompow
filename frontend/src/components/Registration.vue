<template>
    <div id="registration" class="text-center">
        <h2>Create Account</h2>
        <form @submit.prevent="register" class="pt-3 pb-3 rounded">
            <div class="alert alert-danger" role="alert" v-if="registrationErrors">
                There were problems with registering your account, see below.
            </div>
            <label for="username" class="sr-only">Username</label>
            <input v-validate="'required'" data-vv-as="username" v-model="user.username" type="text" id="username" name="username" class="form-control" placeholder="Username" required autofocus />
            <span v-show="errors.has('username')" class="help is-danger">{{errors.first('username')}}</span>
            <label for="password" class="sr-only">Password</label>
            <input v-validate="'required'" v-model="user.password" type="password" id="password" name="password" ref="password" class="form-control" placeholder="Password" required />
            <span v-show="errors.has('password')">{{errors.first('password')}}</span>
            <input v-validate="'required|confirmed:password'" v-model="user.confirmPassword" type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="Confirm Password" required />
            <span v-show="errors.has('confirmPassword')">The passwords do not match.</span>
            <label for="email" class="sr-only">Email Address</label>
            <input type="email" id="email" class="form-control" placeholder="Email Address" v-model="user.email" required />
            
            
            <router-link :to="{ name: 'login'}">Have an account?</router-link>
            <button :disabled="errors.any()" class="btn btn-lg btn-primary btn-block" type="submit">Create Account</button>
        </form>
    </div>
</template>

<script>
import apiCalls from '@/apiCalls';

export default {
    data() {
        return {
            user: {
                username: '',
                password: '',
                confirmPassword: '',
                role: 'standard',
                email: '',
            },
            registrationErrors: false,
        }
    },
    methods: {
        register() {
            apiCalls.post('/register', this.user)
                .then((response) => {
                    if (response.ok) {
                        this.$router.push({ path: '/login', query: { registration: 'success' } });
                    } else {
                        this.registrationErrors = true;
                    }
                })
        }
    }
}
</script>

<style lang="scss" scoped>
#registration {
    background-color: rgb(193, 225, 231);
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
