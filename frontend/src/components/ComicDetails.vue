<template>
    <div id="comicDetails" class="container-fluid rounded py-2 shadow-sm">
        <vue-headful :title="'ZapBoomPow - ' + comic.title" />
        <div v-if="loading">Loading...</div>
        <div v-else class="row px-2">
            <div>
                <v-img :src="comic.image" contain width="550px" height="845px"></v-img>
            </div>
            <div class="mt-3 ml-auto mr-auto col-md-6">
                <h1>{{this.comic.title}}</h1>
                <h5>{{this.comic.description}}</h5>
                <div class="mt-3 row wrap ml-0 text-center">
                    <div>
                        <h5 class="font-weight-bold">Published:</h5>
                        <h5>{{this.comic.publishedDate.toLocaleString('en-us', { month: 'long', year: 'numeric', day: 'numeric'})}}</h5>
                    </div>
                    <div class="mr-auto ml-auto" v-for="(creator, i) in this.comic.creators" :key="i">
                        <h5 class="font-weight-bold">{{creator.role}}:</h5>
                        <h5>{{creator.name}}</h5>
                    </div>
                </div>

                <div v-if="this.currUser != null">
                    <v-menu transition="slide-y-transition" bottom>
                        <template v-slot:activator="{ on }">
                            <v-btn class="purple" color="primary" dark v-on="on">
                                Choose a Collection to add to
                            </v-btn>
                        </template>
                        <v-list>
                            <v-list-tile v-for="collection in userCollections" :key="collection.collection_id" @click="addToCollection(collection.collection_id)">
                                <v-list-tile-title>{{collection.collection_name}}</v-list-tile-title>
                            </v-list-tile>
                        </v-list>
                    </v-menu>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import apiCalls from '@/apiCalls';
import auth from '@/auth'

export default {
    data() {
        return {
            currUser: null,
            loading: true,
            comic: {
                title: 'Title',
                image: '',
                description: 'Description',
                publishedDate: '05/21/2019',
                creators: [],
            },
            userCollections: [],
            collectionToAddTo: ''
        }
    },
    methods: {
        getUserCollections() {
            apiCalls.get(`/collection/all/${this.currUser.uid}`)
                .then((response) => {
                    response.data.forEach(collection => {
                        this.userCollections.push(collection);
                    });
                    this.collectionToAddTo = this.userCollections[0].id;
                });
        },
        addToCollection(collectionId) {
            apiCalls.post(`/collection/add`, { 'collection_id': collectionId, 'comic_id': this.$route.params.id})
                .then(() => {
                    this.$router.push(`/collections/${collectionId}`);
                });
        }
    },
    created() {
        this.currUser = auth.getUser();
        this.getUserCollections();
        apiCalls.marvelGet(`/comics/${this.$route.params.id}`)
            .then((response) => {
                console.log(response);
                let comicData = response.data.data.results[0];
                this.comic.title = comicData.title;
                if (comicData.images.length < 1) {
                    this.comic.image = comicData.thumbnail.path + "/detail." + comicData.thumbnail.extension;
                } else {
                    this.comic.image = comicData.images[0].path + "/detail." + comicData.images[0].extension;
                }
                this.comic.description = comicData.description;
                this.comic.publishedDate = new Date(comicData.dates[0].date);
                comicData.creators.items.forEach(element => {
                    this.comic.creators.push({ name: element.name, role: element.role });
                });
                this.loading = false;
            })
            .catch(() => this.$router.push('/404'));
    }
}
</script>

<style lang="scss" scoped>
#comicDetails {
    background-color: rgb(193, 225, 231);
}
</style>

