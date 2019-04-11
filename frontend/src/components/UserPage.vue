<template>
    <div id="user" class="container rounded">
        <div class="row">
            <div id="profile" class="col col-sm-auto pt-2">
                <h2>{{this.profile.username}}'s profile</h2>
                <div v-for="collection in profile.collections" :key="collection.collection_id">
                    <p>{{collection.collection_name}}</p>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
const axios = require('axios');
import auth from '@/auth';

const instance = axios.create({
    baseURL: `${process.env.VUE_APP_REMOTE_API}`,
    headers: {
        'Authorization': "Bearer " + auth.getToken(),
        'Content-Type': 'application/json',
    },
});

export default {
    props: {
        userID: String,
    },
    data() {
        return {
            profile: {
                username: '',
                collections: []
            }
        }
    },
    methods: {
        getProfileById() {
            instance.get(`/user/${this.userID}`)
            .then((response) => {
                console.log(response.data);
                this.profile.username = response.data.username;
            });
        },
        getProfileCollections() {
            instance.get(`/collection/all/${this.userID}`)
            .then((response) => {
                console.log(response.data);
                response.data.forEach((collection) => {
                    if (collection.public_bool == true || this.userID == collection.user_id) {
                        console.log(collection);
                        this.profile.collections.push(collection);
                    }
                })
            });
        },
    },
    created() {
        this.getProfileById();
        this.getProfileCollections();
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
        background-color: rgba(255, 255, 255, 0.4);
    }
}

</style>

