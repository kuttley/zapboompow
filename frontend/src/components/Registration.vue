<template>
    <div id="registration" class="text-center">
        <vue-headful title="ZapBoomPow - Registration" />
        <h2 class="mt-2">Create Account</h2>
        <form @submit.prevent="register" class="pt-3 pb-3 rounded">
            <div class="alert alert-danger" role="alert" v-if="registrationErrors.length > 0">
                There were problems with registering your account.
                <p v-for="error in registrationErrors" :key="error" class="mb-0">{{error}}</p>
            </div>
            <label for="username" class="sr-only">Username</label>
            <input v-validate="'required|uniqueUsername|length:6,30'" data-vv-as="username" v-model="user.username" type="text" id="username" name="username" class="form-control" placeholder="Username" required autofocus />
            <span>{{errors.first('username')}}</span>
            <label for="password" class="sr-only">Password</label>
            <input v-validate="'required|length:4,32'" v-model="user.password" type="password" id="password" name="password" ref="password" class="form-control" placeholder="Password" required />
            <span v-show="errors.has('password')">{{errors.first('password')}}</span>
            <input v-validate="'required|confirmed:password|length:4,32'" v-model="user.confirmPassword" type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="Confirm Password" required />
            <span v-show="errors.has('confirmPassword')">The passwords do not match.</span>
            <label for="email" class="sr-only">Email Address</label>
            <input v-validate="'required|email|uniqueEmail'" type="email" name="email" id="email" class="form-control" placeholder="Email Address" v-model="user.email" required />
            <span v-show="errors.has('email')">{{errors.first('email')}}</span>
            <v-layout column align-start fill-height ml-4>
                <div>
                    <input name="rolecheck" id="rolecheck" class="form-check-input" v-model="isPremiumChecked" type="checkbox" />
                    <label class="form-check-label" for="rolecheck">Upgrade to premium account!</label>
                </div>
                <div>
                    <input v-validate="'required:true'" name="agecheck" id="agecheck" class="form-check-input" v-model="user.over18" type="checkbox" required />
                    <label class="form-check-label" for="agecheck">I am over 18</label>
                </div>
            </v-layout>
            
            <v-layout align-center justify-space-around row fill-height wrap>
                <router-link :to="{ name: 'login'}">Have an account?</router-link>
                <button :disabled="errors.any()" class="btn btn-lg btn-primary" type="submit">Create Account</button>
            </v-layout>
        </form>
    </div>
</template>

<script>
import apiCalls from '@/apiCalls';
import { Validator } from 'vee-validate';

export default {
    data() {
        return {
            user: {
                username: '',
                password: '',
                confirmPassword: '',
                role: 'standard',
                email: '',
                over18: false,
            },
            registrationErrors: [],
        }
    },
    methods: {
        register() {
            apiCalls.post('/register', this.user)
                .then((response) => {
                    if (response.data.success) {
                        this.$router.push({ path: '/login', query: { registration: 'success' } });
                    } else {
                        this.registrationErrors = response.data.errors;
                    }
                });
        }
    },
    mounted() {
        const isEmailUnique = (value) => {
            return apiCalls.post(`/api/validate/email`, value)
                .then((response) => {
                    if (response.data == true) {
                        return { 
                            valid: false,
                            data: {
                                message: `${value} is already taken.`
                            }
                        }
                    } else {
                        return {
                            valid: true
                        }
                    }
                });
        };

        const isUsernameUnique = (value) => {
            return apiCalls.post(`/api/validate/username`, value)
                .then((response) => {
                    if (response.data == true) {
                        return { 
                            valid: false,
                            data: {
                                message: `${value} is already taken.`
                            }
                        }
                    } else {
                        return {
                            valid: true
                        }
                    }
                });
        };

        Validator.extend("uniqueEmail", {
            validate: isEmailUnique,
            getMessage: (field, params, data) => data.message
        });

        Validator.extend("uniqueUsername", {
            validate: isUsernameUnique,
            getMessage: (field, params, data) => data.message
        });
    },
    computed: {
        isPremiumChecked: {
            get() {
                return this.user.role == 'premium';
            },
            set(value) {
                if (value == true) {
                    this.user.role = 'premium';
                } else {
                    this.user.role = 'standard';
                }
            }
        },
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
