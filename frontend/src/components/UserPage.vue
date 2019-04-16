<template>
    <div id="user" class="container rounded shadow-sm pt-2">
        <vue-headful :title="title" />
        <div v-if="loading">Loading...</div>
        <div v-else>
            <div v-if="this.currUser != null && this.currUser.uid == this.profileID">
                <h2>Your profile</h2>
                <h5>Your Collections</h5>
            </div>
            <div v-else>
                <h2>{{this.profile.username}}'s profile</h2>
                <h5>Public Collections</h5>
            </div>

            <collection-list :profileID="this.profileID" />
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
            title: '',
            currUser: null,
            loading: true,
            profile: {
                username: '',
                collections: []
            }
        }
    },
    methods: {
        getProfileById() {
            apiCalls.get(`/user/${this.profileID}`)
                .then((response) => {
                    console.log(response);
                    this.profile.username = response.data.username;
                    this.title = "ZapBoomPow - " + this.profile.username;
                    this.loading = false;
                })
                .catch(() => this.$router.push('/404'));
        },
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

