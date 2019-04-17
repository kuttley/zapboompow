<template>
    <div id="collectionDetails" class="container-fluid rounded py-2 shadow-sm">
        <vue-headful :title="'ZapBoomPow - \'' + title + '\' Collection'" />
        <div v-if="loading">Loading...</div>
        <div v-else>
            <div v-if="collectionDetails == null">
                <h2 class="text-center">You don't have access to this collection.</h2>
            </div>
            <div v-else>
                <h2>{{this.collectionDetails.collection_name}} Collection</h2>
                <h3 v-if="this.collectionDetails.comic_ids_in_collection < 1">No comics in this collection.</h3>
                <div v-else>
                    <v-container fluid grid-list-md>
                        <v-layout row wrap>
                        <v-flex v-for="comic in collectionComics" :key="comic.id" md2 sm5 xs12>
                            <v-card color="rgba(255,255,255,0.4)">
                            <router-link :to="`/comic/${comic.id}`">
                                <v-img :src="comic.thumbnail" height="200px" contain>
                                </v-img>
                                <v-card-title primary-title class="text-center justify-content-center">
                                    <h4 class="grey--text text--darken-4">{{ comic.title }}</h4>
                                </v-card-title>
                            </router-link>
                            </v-card>
                        </v-flex>
                        </v-layout>
                    </v-container>
                </div>
                <h2>{{this.collectionDetails}}</h2>
            </div>
        </div>
    </div>
</template>

<script>
import apiCalls from '@/apiCalls';
import auth from '@/auth';

export default {
    data() {
        return {
            title: '',
            loading: true,
            collectionDetails: null,
            collectionComics: [],
        }
    },
    methods: {
        getCollectionDetails() {
            apiCalls.get(`/collection/${this.$route.params.id}`)
                .then((response) => {
                    if (response.data.public_bool) {
                        this.collectionDetails = response.data;
                        this.title = this.collectionDetails.collection_name;
                        this.getComicsForCollection();
                    } else {
                        if (auth.getUser() != null) {
                            if (auth.getUser().uid == response.data.user_id) {
                                this.collectionDetails = response.data;
                                this.title = this.collectionDetails.collection_name;
                                this.getComicsForCollection();
                            } else {
                                this.loading = false;
                                this.title = 'Private Collection'
                            }
                        } else {
                            this.loading = false;
                            this.title = 'Private Collection';
                        }
                    }
                })
                .catch(() => this.$router.push('/404'));
        },
        getComicsForCollection() {
            for (let i = 0; i < this.collectionDetails.comic_ids_in_collection.length; i++) {
                apiCalls.marvelGet(`/comics/${this.collectionDetails.comic_ids_in_collection[i]}`)
                    .then((response) => {
                        let comicData = response.data.data.results[0];
                        let comicInfo = {};
                        comicInfo.id = comicData.id;
                        comicInfo.title = comicData.title;
                        comicInfo.thumbnail = `${(comicData.thumbnail.path.includes('image_not_available') && comicData.images.length > 0) ? comicData.images[0].path : comicData.thumbnail.path}/portrait_medium.${comicData.thumbnail.extension}`;
                        this.collectionComics.push(comicInfo);
                    });
            }
            this.loading = false;
        },
    },
    created() {
        this.getCollectionDetails();
    }

}
</script>

<style lang="scss" scoped>
#collectionDetails {
    background-color: rgb(193, 225, 231);
}
</style>

