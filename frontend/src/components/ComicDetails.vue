<template>
    <div id="comicDetails" class="container-fluid rounded py-2 shadow-sm">
        <div v-if="loading">Loading...</div>
        <div v-else class="row px-2">
            <div>
                <v-img :src="comic.image" contain width="300px" height="450px"></v-img>
            </div>
            <div class="ml-auto mr-auto col-md-6">
                <h1>{{this.comic.title}}</h1>
                <h5>{{this.comic.description}}</h5>
                <div class="row ml-0 text-center">
                    <div>
                        <h5 class="font-weight-bold">Published:</h5>
                        <h5>{{this.comic.publishedDate.toLocaleString('en-us', { month: 'long', year: 'numeric', day: 'numeric'})}}</h5>
                    </div>
                    <div class="mr-auto ml-auto" v-for="creator in this.comic.creators" :key="creator.role">
                        <h5 class="font-weight-bold">{{creator.role}}:</h5>
                        <h5>{{creator.name}}</h5>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import apiCalls from '@/apiCalls';

export default {
    data() {
        return {
            loading: true,
            comic: {
                title: '',
                image: '',
                description: '',
                publishedDate: '',
                creators: [],
            }
        }
    },
    methods: {

    },
    created() {
        apiCalls.marvelGet(`/comics/${this.$route.params.id}`)
            .then((response) => {
                let comicData = response.data.data.results[0];
                console.log(comicData);
                this.comic.title = comicData.title;
                this.comic.image = comicData.images[0].path + "/portrait_uncanny." + comicData.images[0].extension;
                this.comic.description = comicData.description;
                this.comic.publishedDate = new Date(comicData.dates[0].date);
                comicData.creators.items.forEach(element => {
                    this.comic.creators.push({ name: element.name, role: element.role });
                });
                this.loading = false;
            });
    }
}
</script>

<style lang="scss" scoped>
#comicDetails {
    background-color: rgb(193, 225, 231);
}
</style>

