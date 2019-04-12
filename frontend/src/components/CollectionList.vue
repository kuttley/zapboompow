<template>
    <v-container fluid grid-list-md>
        <v-layout row wrap justify-center>
            <v-flex v-for="collection in collections" :key="collection.collection_id" md2 sm5 xs12>
                <v-card class="pt-3">
                    <v-img :src="collection.thumbnail" height="150" contain></v-img>
                    <v-card-title primary-title class="text-center justify-content-center">
                        <div>
                            <h4 class="mb-0">{{collection.collection_name}}</h4>
                            <div>{{collection.comic_ids_in_collection.length}} comic{{(collection.comic_ids_in_collection.length > 1 || collection.comic_ids_in_collection.length == 0) ? 's' : ''}} in collection</div>
                        </div>
                    </v-card-title>
                </v-card>
            </v-flex>
        </v-layout>
    </v-container>
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

const marvel = axios.create({
    baseURL: 'https://gateway.marvel.com:443/v1/public/',
    headers: {
        'Content-Type': 'application/json',
    },
    params: {
        ts:`${process.env.VUE_APP_MARVEL_API_TS}`,
        apikey:`${process.env.VUE_APP_MARVEL_API_KEY}`,
        hash:`${process.env.VUE_APP_MARVEL_API_HASH}`
    }
});

export default {
    data() {
        return {
            collections: [],
        }
    },
    methods: {
        getCollectionList() {
            backend.get(`/collection/all`)
            .then((response) => {
                response.data.forEach((collection) => {
                    if (collection.public_bool == true || this.currUser.uid == collection.user_id) {
                        console.log(collection);
                        this.getThumbnailForCollection(collection);
                    }
                })
            });
        },
        getThumbnailForCollection(collection) {
            const firstComicIdInCollection = collection.comic_ids_in_collection[0];
            if (firstComicIdInCollection != undefined) {
                marvel.get(`/comics/${firstComicIdInCollection}`)
                .then((response) => {
                    console.log(response);
                    collection.thumbnail = response.data.data.results[0].thumbnail.path + '/portrait_medium.' + response.data.data.results[0].thumbnail.extension;
                    this.collections.push(collection);
                });
            } else {
                collection.thumbnail = '';
                this.collections.push(collection);
            }
        },
    },
}
</script>

<style lang="scss" scoped>

</style>

