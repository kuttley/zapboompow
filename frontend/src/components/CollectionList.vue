<template>
    <v-container fluid grid-list-md>
        <v-layout row wrap justify-center>
            <v-flex v-for="collection in collections" :key="collection.collection_id" md2 sm5 xs12>
                <v-card min-height="261" min-width="170" max-width="170">
                    <v-img :src="collection.thumbnail" height="150" contain></v-img>
                    <v-card-title primary-title class="text-center justify-content-center">
                        <div>
                            <h4 class="mb-0">{{collection.collection_name}}</h4>
                            <p v-if="profileID == null" class="mb-1">{{collection.username}}</p>
                            <p v-if="collection.public_bool == false" class="mb-1">Private</p>
                            <div>{{collection.comic_ids_in_collection.length}} comic{{(collection.comic_ids_in_collection.length > 1 || collection.comic_ids_in_collection.length == 0) ? 's' : ''}} in collection</div>
                        </div>
                    </v-card-title>
                </v-card>
            </v-flex>
        </v-layout>
    </v-container>
</template>

<script>
import apiCalls from '@/apiCalls';

export default {
    props: {
        profileID: String,
    },
    data() {
        return {
            collections: [],
        }
    },
    methods: {
        getCollectionList() {
            if (this.profileID != null) {
                apiCalls.get(`/collection/all/${this.profileID}`)
                    .then((response) => {
                        response.data.forEach((collection) => {
                            this.getThumbnailForCollection(collection);
                        })
                    });
            } else {
                apiCalls.get(`/collection/all`)
                    .then((response) => {
                        response.data.forEach((collection) => {
                            apiCalls.get(`/user/${collection.user_id}`)
                                .then((response) => {
                                    collection.username = response.data.username;
                                    this.getThumbnailForCollection(collection);
                                });
                        });
                    });
            }
        },
        getThumbnailForCollection(collection) {
            const firstComicIdInCollection = collection.comic_ids_in_collection[0];
            if (firstComicIdInCollection != undefined) {
                apiCalls.marvelGet(`/comics/${firstComicIdInCollection}`)
                    .then((response) => {
                        collection.thumbnail = response.data.data.results[0].thumbnail.path + '/portrait_medium.' + response.data.data.results[0].thumbnail.extension;
                        this.collections.push(collection)
                    .catch(() => {
                        collection.thumbnail = '';
                        this.collections.push(collection);  
                    });
                });
            } else {
                collection.thumbnail = '';
                this.collections.push(collection);
            }
        },
    },
    created() {
        this.getCollectionList();
    }
}
</script>

<style lang="scss" scoped>

</style>

