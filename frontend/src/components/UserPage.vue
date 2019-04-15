<template>
    <div id="user" class="container rounded">
        <vue-headful :title="title" />
        <div class="row">
            <div id="profile" class="col col-sm-auto pt-2 shadow-sm">
                <div v-if="this.currUser.uid == this.profileID">
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
                console.log(response.data);
                this.profile.username = response.data.username;
                this.title = "ZapBoomPow - " + this.profile.username;
            });
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
    #profile {
        width: 100%;
        background-color: rgb(193, 225, 231);
    }
}

</style>

