<template>
    <div id="createCollectPage" class="container rounded shadow-sm text-center">
        <h3>Create a new Collection</h3>
        <v-layout align-center justify-center column>
            <div>
                <form @submit.prevent="createCollection">
                    <v-text-field label="Collection Name" v-model="newCollection.collectionName" clearable name="collectionName" v-validate="'required'" />

                    <v-checkbox v-model="newCollection.isPublic" label="Public"></v-checkbox>

                    <v-btn type='submit'>submit</v-btn>
                </form>
            </div>
        </v-layout>
    </div>
</template>

<script>
const axios = require('axios');
import auth from '@/auth';

const backend = axios.create({
    baseURL: `${process.env.VUE_APP_REMOTE_API}`,
    headers: {
        'Authorization': "Bearer " + auth.getToken(),
        'Content-Type': 'application/json',
    },
});

export default {
    name: "create-collection-page",
    data() {
        return {
            currUser: auth.getUser(),
            newCollection: {
                collectionName: '',
                isPublic: true,
            },
        }
    },
    methods: {
        createCollection() {
            backend.post('/collection/add', this.newCollection)
            .then(() => {
                this.$router.push('/user/' + this.currUser.uid);
            })
            .catch((err) => console.log(err));
        },
    },
}
</script>

<style lang="scss" scoped>
#createCollectPage {
    width: 100%;
    background-color: rgba(255, 255, 255, 0.4);
}
</style>

