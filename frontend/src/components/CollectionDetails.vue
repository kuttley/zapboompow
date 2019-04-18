<template>
    <div id="collectionDetails" class="container-fluid rounded py-2 shadow-sm">
        <vue-headful :title="'ZapBoomPow - \'' + title + '\' Collection'" />
        <div v-if="loading">Loading...</div>
        <div v-else>
            <div v-if="collectionDetails == null">
                <h2 class="text-center">You don't have access to this collection.</h2>
            </div>
            <div v-else>
                <v-layout mx-0 row justify-space-between align-center wrap>
                    <h2 class="my-0">{{this.collectionDetails.collection_name}} Collection</h2>
                    <div class="mr-2 text-center" v-if="this.currUser != null">
                        <v-icon :color="`${favorited == true ? 'red' : ''}`" @click="favoriteCollection()">favorite</v-icon>
                        <p class="my-0">{{this.collectionDetails.num_favorites}} favs</p>
                    </div>
                </v-layout>
                <v-layout justify-end v-if="this.collectionDetails.public_bool == true">
                    <v-tooltip color="green" left v-model="copied">
                        <template v-slot:activator="copied">
                            <v-btn class="mb-0 mr-0" small color="info" @click="copyToClipboard"><v-icon class="pr-1">file_copy</v-icon>Share this collection</v-btn>
                        </template>
                        <span>Zap! Link copied!</span>
                    </v-tooltip>
                </v-layout>
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
                            <v-icon @click="removeFromCollection(comic.id)">delete</v-icon>
                            </v-card>
                        </v-flex>
                        </v-layout>
                    </v-container>
                </div>
                <div v-if="this.currUser != null && this.currUser.uid == this.collectionDetails.user_id">
                    <div v-if="deleted == null">
                        <v-layout align-end column>
                            <div class="row m-0">
                                <v-text-field v-model="collectionRename" label="Rename Collection" v-on:keyup.enter="renameCollection(); collectionRename = '';" hide-details></v-text-field>
                                <v-btn @click.prevent="renameCollection(); collectionRename = '';" color="info" dark>Rename</v-btn>
                            </div>
                            <div>
                                <v-btn @click.prevent="deleteCollectionConfirmation=true" :loading="deleted" :disabled="deleted" color="warning" dark>Delete Collection</v-btn>
                            </div>
                        </v-layout>
                        <v-layout row justify-center>
                            <v-dialog v-model="deleteCollectionConfirmation" persistent max-width="290">
                            
                            <v-card>
                                <v-card-title class="headline">Are you really sure you want to do this?</v-card-title>
                                <v-card-text>Once you click Confirm Delete your collection is gone like pixel dust in the hands of Thanos :(</v-card-text>
                                <v-card-actions>
                                <v-spacer></v-spacer>
                                <v-btn color="green darken-1" flat @click="deleteCollectionConfirmation= false">Cancel</v-btn>
                                <v-btn color="green darken-1" flat @click="deleteCollection">Confirm Delete</v-btn>
                                </v-card-actions>
                            </v-card>
                            </v-dialog>
                        </v-layout>
                    </div>
                    <div v-else-if="deleted == true">
                        <v-alert :value="true" type="success">Collection deleted...</v-alert>
                    </div>
                    <div v-else>
                        <v-alert :value="true" type="error">Could not delete collection.</v-alert>
                    </div>
                </div>
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
            deleted: null,
            currUser: auth.getUser(),
            collectionRename: '',
            favorited: false,
            copied: false,
            deleteCollectionConfirmation: false,
        }
    },
    methods: {
        getCollectionDetails() {
            apiCalls.get(`/collection/${this.$route.params.id}`)
                .then((response) => {
                    if (response.data.public_bool) {
                        this.collectionDetails = response.data;
                        this.title = this.collectionDetails.collection_name;
                        if (this.currUser != null) {
                            apiCalls.get(`/user/favorites/${this.currUser.uid}`)
                                .then((response) => {
                                    let comicID = this.$route.params.id;
                                    if (response.data.includes(comicID.toString())) {
                                        this.favorited = true;
                                    }
                                    this.getComicsForCollection();
                                })
                                .catch(() => { this.getComicsForCollection(); });
                        } else {
                            this.getComicsForCollection();
                        }
                    } else {
                        if (this.currUser != null) {
                            if (this.currUser.uid == response.data.user_id) {
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
                apiCalls.get(`/comic/id/${this.collectionDetails.comic_ids_in_collection[i]}`)
                    .then((response) => {
                        let comicData = response.data;
                        let comicInfo = {};
                        comicInfo.id = comicData.comic_id;
                        comicInfo.title = comicData.comic_title;
                        comicInfo.thumbnail = comicData.comic_image;
                        this.collectionComics.push(comicInfo);
                    })
                    .catch(() => {
                        apiCalls.marvelGet(`/comics/${this.collectionDetails.comic_ids_in_collection[i]}`)
                            .then((response) => {
                                let comicData = response.data.data.results[0];
                                let comicInfo = {};
                                comicInfo.id = comicData.id;
                                comicInfo.title = comicData.title;
                                comicInfo.thumbnail = `${(comicData.thumbnail.path.includes('image_not_available') && comicData.images.length > 0) ? comicData.images[0].path : comicData.thumbnail.path}/portrait_medium.${comicData.thumbnail.extension}`;
                                this.collectionComics.push(comicInfo);
                            });
                    });
            }
            this.loading = false;
        },
        deleteCollection() {
            apiCalls.post('/collection/delete', this.$route.params.id)
                .then((response) => {
                    if (response.data == true) {
                        this.deleted = true;
                        setTimeout(() => this.$router.push(`/user/${this.currUser.uid}`), 2000);
                    } else {
                        this.deleted = false;
                    }
                })
                .catch(() => this.deleted = false);
        },
        renameCollection() {
            this.collectionDetails.collection_name = this.collectionRename;
            apiCalls.post('/collection/rename', this.collectionDetails);
        },
        favoriteCollection() {
            if (this.favorited == true) {
                apiCalls.post('/removeFromFavorites', { 'user_id': this.currUser.uid, 'collection_id': this.collectionDetails.collection_id});
                this.favorited = false;
                this.collectionDetails.num_favorites--;
            } else {
                apiCalls.post('/addToFavorites', { 'user_id': this.currUser.uid, 'collection_id': this.collectionDetails.collection_id});
                this.favorited = true;
                this.collectionDetails.num_favorites++;
            }
        },
        copyToClipboard() {
            let link = document.createElement("textarea");
            link.value = window.location.href;
            document.body.appendChild(link);
            link.select();
            document.execCommand("copy");
            document.body.removeChild(link);
            this.copied = true;
            setTimeout(() => { this.copied = false; }, 2000);
        },
        removeFromCollection(comicId) {
            apiCalls.post(`/collection/remove`, { 'collection_id': this.$route.params.id, 'comic_id': comicId})
                .then(() => {
                    this.$emit('reload');
                });
        }
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

