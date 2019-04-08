<template>
    <div id="registration" class="text-center">
        <h2>Create Account</h2>
        <form @submit.prevent="register" class="pt-3 pb-3 rounded">
            <div class="alert alert-danger" role="alert" v-if="registrationErrors">
                There were problems with registering your account, see below.
            </div>
            <label for="username" class="sr-only">Username</label>
            <input type="text" id="username" class="form-control" placeholder="Username" v-model="user.username" required autofocus />
            <label for="password" class="sr-only">Password</label>
            <input type="password" id="password" class="form-control" placeholder="Password" v-model="user.password" required />
            <input type="password" id="confirmPassword" class="form-control" placeholder="Confirm Password" v-model="user.confirmPassword" required />
            <label for="email" class="sr-only">Email Address</label>
            <input type="email" id="email" class="form-control" placeholder="Email Address" v-model="user.email" required />
            <label for="dateOfBirth" class="sr-only">Date Of Birth</label>
            <input type="date" id="dateOfBirth" class="form-control" v-model="user.dateOfBirth" required />
            
            
            <router-link :to="{ name: 'login'}">Have an account?</router-link>
            <button class="btn btn-lg btn-primary btn-block" type="submit">Create Account</button>
        </form>
    </div>
</template>

<script>
export default {
    data() {
        return {
            user: {
                username: '',
                password: '',
                confirmPassword: '',
                role: 'standard',
                email: '',
                dateOfBirth: '',
            },
            registrationErrors: false,
        }
    },
    methods: {
        register() {
            fetch(`${process.env.VUE_APP_REMOTE_API}/register`, {
                method: 'POST',
                headers: {
                Accept: 'application/json',
                'Content-Type': 'application/json',
                },
                body: JSON.stringify(this.user),
            })
            .then((response) => {
                if (response.ok) {
                    console.log(`${process.env.VUE_APP_REMOTE_API}/register`);
                    this.$router.push({ path: '/login', query: { registration: 'success' } });
                } else {
                    this.registrationErrors = true;
                }
                })
            .then((err) => console.error(err));
        }
    }
}
</script>

<style lang="scss" scoped>
#registration {
    background-color: rgba(255, 255, 255, 0.4);
}
h2, form {
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
