<template>
    <div id="premiumUpgrade" class="container-fluid rounded py-2 shadow-sm">
        <vue-headful title="ZapBoomPow - Upgrade Account" />
        <h2 class="text-center">Upgrading to Premium?</h2>
        <div v-if="this.upgrading == true">
            <v-alert :value="true" type="success">Thanks for upgrading!</v-alert>
        </div>
        <v-layout row wrap py-2>
            <v-img :src="image" contain max-height="600px"></v-img>
            <div class="col col-md-6 align-self-center">
                <h4>Welcome to the big kids crew.</h4>
                <v-btn :disabled="upgrading" color="deep-purple white--text" @click="upgradeAccount()">Upgrade!</v-btn>
            </div>
        </v-layout>
    </div>
</template>

<script>
import auth from '@/auth';
import apiCalls from '@/apiCalls';

export default {
    data() {
        return {
            upgrading: false,
            image: require('@/assets/upgrade.jpg'),
        }
    },
    methods: {
        upgradeAccount() {
            this.upgrading = true;
            apiCalls.post('/upgrade', auth.getUser().uid)
                .then((response) => {
                    if (response.data.includes('"')) {
                        response.data = response.data.replace(/"/g, '');
                    }
                    auth.destroyToken();
                    auth.saveToken(response.data);
                    setTimeout(() => this.$router.push('/'), 3000);
                });
        }
    }
}
</script>

<style lang="scss" scoped>
#premiumUpgrade {
    background-color: rgb(193, 225, 231);
}
</style>

