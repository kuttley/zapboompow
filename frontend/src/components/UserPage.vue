<template>
    <div id="user" class="container rounded">
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

                <v-container fluid grid-list-md>
                    <v-layout row wrap justify-center>
                        <v-flex v-for="collection in profile.collections" :key="collection.collection_id" md2 sm5 xs12>
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

            </div>
        </div>
    </div>
</template>

<script>
import auth from '@/auth';
import apiCalls from '@/apiCalls';

export default {
    props: {
        profileID: String,
    },
    data() {
        return {
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
            });
        },
        getProfileCollections() {
            console.log(auth.getToken());
            apiCalls.get(`/collection/all/${this.profileID}`)
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
                apiCalls.marvelGet(`/comics/${firstComicIdInCollection}`)
                .then((response) => {
                    console.log(response);
                    collection.thumbnail = response.data.data.results[0].thumbnail.path + '/portrait_medium.' + response.data.data.results[0].thumbnail.extension;
                    this.profile.collections.push(collection);
                })
                .catch(() => null);
            } else {
                collection.thumbnail = '';
                this.profile.collections.push(collection);
            }
        },
    },
    created() {
        this.currUser = auth.getUser();
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
        background-color: rgb(193, 225, 231);
    }
}

</style>

