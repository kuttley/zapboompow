<template>
    <div id="user" class="container rounded shadow-sm pt-2">
        <vue-headful :title="title" />
        <div v-if="loading">Loading...</div>
        <div v-else>
            <div v-if="this.currUser != null && this.currUser.uid == this.profileID">
                <div class="row ml-1 mb-3">
                    <h2 class="mb-0">Your profile</h2>
                    <v-tooltip right>
                        <template v-slot:activator="{on}">
                            <v-icon v-if="profile.role == 'premium'" color="light-green darken-1" class="ml-1" v-on="on">verified_user</v-icon>
                        </template>
                        <span>Premium User</span>
                    </v-tooltip>
                </div>
                <h5>Your Collections</h5>

                <collection-list :profileID="this.profileID" v-on:reload="reload" :key="componentKey" />

                <h5>Your favorites</h5>
                <collection-list :favorites="true" :profileID="this.profileID" v-on:reload="reload" :key="componentKey" />
            </div>
            <div v-else>
                <div class="row ml-1 mb-3">
                    <h2 class="mb-0">{{this.profile.username}}'s profile</h2>
                    <v-tooltip right>
                        <template v-slot:activator="{on}">
                            <v-icon v-if="profile.role == 'premium'" color="light-green darken-1" class="ml-1" v-on="on">verified_user</v-icon>
                        </template>
                        <span>Premium User</span>
                    </v-tooltip>
                </div>
                <h5>Public Collections</h5>

                <collection-list :profileID="this.profileID" />

                <h5>{{this.profile.username}}'s favorites</h5>
                <collection-list :favorites="true" :profileID="this.profileID" />
            </div>
        </div>
    </div>
</template>

<script>
import auth from '@/auth';
import apiCalls from '@/apiCalls';
import CollectionList from '@/components/CollectionList.vue';

export default {
    components: {
        CollectionList
    },
    props: {
        profileID: String,
    },
    data() {
        return {
            componentKey: 0,
            title: '',
            currUser: null,
            loading: true,
            profile: {
                username: '',
                role: '',
                collections: []
            }
        }
    },
    methods: {
        getProfileById() {
            apiCalls.get(`/user/${this.profileID}`)
                .then((response) => {
                    this.profile.username = response.data.username;
                    this.profile.role = response.data.role;
                    this.title = "ZapBoomPow - " + this.profile.username;
                    this.loading = false;
                })
                .catch(() => this.$router.push('/404'));
        },
        reload() {
            this.componentKey += 1;
        }
    },
    created() {
        this.currUser = auth.getUser();
        this.getProfileById();
    },
}
</script>

<style lang="scss" scoped>
.container {
  margin-left: 0;
}

#user {
    width: 100%;
    background-color: rgb(193, 225, 231);
}

</style>

