<template>
    <v-container fluid grid-list-md>
        <v-layout row wrap>
            <v-flex v-for="collection in collections" :key="collection.collection_id" offset-xs2 offset-xl1 offset-md1 offset-sm1 offset-lg1 xl2 md3 sm5 xs12 v-bind="{[`order-${collection.collection_id}`] : true}">
                <v-card tile min-height="195" max-width="170" color="rgba(255,255,255,0.4)">
                    <router-link :to="`/collections/${collection.collection_id}`">
                        <v-img :src="collection.thumbnail" height="150" my-2 contain></v-img>
                        <v-card-title primary-title class="pt-2 text-center justify-content-center grey--text text--darken-4">
                            <div>
                                <h4 class="mb-0">{{collection.collection_name}}</h4>
                                <p v-if="profileID == null" class="mb-0">{{collection.username}}</p>
                                <p v-if="collection.public_bool == false" class="mb-0">Private</p>
                                <div class="mb-0">{{collection.comic_ids_in_collection.length}} comic{{(collection.comic_ids_in_collection.length > 1 || collection.comic_ids_in_collection.length == 0) ? 's' : ''}} in collection</div>
                            </div>
                        </v-card-title>
                    </router-link>
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
        featuredCollections: Boolean,
        favorites: Boolean,
    },
    data() {
        return {
            collections: [],
        }
    },
    methods: {
        getCollectionList() {
            if (this.profileID != null) {
                if (this.favorites == true) {
                    apiCalls.get(`/user/favorites/${this.profileID}`)
                        .then((response) => {
                            response.data.forEach((collectionID) => {
                                apiCalls.get(`/collection/${collectionID}`)
                                    .then((response) => {
                                        this.getThumbnailForCollection(response.data);
                                    });
                            });
                        });
                } else {
                    apiCalls.get(`/collection/all/${this.profileID}`)
                        .then((response) => {
                            response.data.forEach((collection) => {
                                if (this.featuredCollections == true) {
                                    if (collection.featured == true || collection.num_favorites >= 5) {
                                        this.getThumbnailForCollection(collection);
                                    }
                                } else {
                                    this.getThumbnailForCollection(collection);
                                }
                            });
                        });
                }
            } else {
                apiCalls.get(`/collection/all`)
                    .then((response) => {
                        response.data.forEach((collection) => {
                            if (this.featuredCollections == true) {
                                if (collection.featured == true || collection.num_favorites >= 5) {
                                    apiCalls.get(`/user/${collection.user_id}`)
                                        .then((response) => {
                                            collection.username = response.data.username;
                                            this.getThumbnailForCollection(collection);
                                        });
                                }
                            } else {
                                apiCalls.get(`/user/${collection.user_id}`)
                                    .then((response) => {
                                        collection.username = response.data.username;
                                        this.getThumbnailForCollection(collection);
                                    });
                            }
                        });
                    });
            }
        },
        getThumbnailForCollection(collection) {
            const firstComicIdInCollection = collection.comic_ids_in_collection[0];
            if (firstComicIdInCollection != undefined) {
                apiCalls.get(`/comic/id/${firstComicIdInCollection}`)
                    .then((response) => {
                        collection.thumbnail = response.data.comic_image;
                        this.collections.push(collection);
                    })
                    .catch(() => {
                        apiCalls.marvelGet(`/comics/${firstComicIdInCollection}`)
                            .then((response) => {
                                collection.thumbnail = response.data.data.results[0].thumbnail.path + '/portrait_medium.' + response.data.data.results[0].thumbnail.extension;
                                this.collections.push(collection);
                            })
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

