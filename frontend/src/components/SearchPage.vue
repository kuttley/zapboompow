<template>
    <div id="searchPage" class="container-fluid rounded py-2 shadow-sm">
      <div v-if="loading">Loading...</div>
      <div v-else>
        <div v-if="comics.length > 0">
          <v-container fluid grid-list-md>
            <v-layout row wrap>
              <v-flex v-for="comic in comics" :key="comic.id" md2 sm5 xs12>
                <v-card color="rgba(255,255,255,0.4)">
                  <router-link :to="`/comic/${comic.id}`">
                    <v-img :src="
                      `${(comic.thumbnail.path.includes('image_not_available') && comic.images.length > 0) ? comic.images[0].path : comic.thumbnail.path}/portrait_medium.${comic.thumbnail.extension}`" 
                      height="200px" contain>
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
        <div v-else>
          <h2 class="text-center">No results found.</h2>
        </div>
      </div>
    </div>
</template>

<script>
import apiCalls from '@/apiCalls';

export default {
 
  data() {
    return {
      comics: [],
      loading: true,
      searchComicName: this.$route.query.title,
      searchIssueNumber: this.$route.query.issueNumber
    };
  },
  methods: {
    getComics() {
        apiCalls.marvelGet(`/comics?${this.searchComicName.length > 0 ? 'title=' + this.searchComicName : '' }${this.searchIssueNumber.length > 0 ? '&issueNumber=' + this.searchIssueNumber : ''}`)
          .then((response) => {
            console.log(response);
            this.comics = response.data.data.results;
            this.loading = false;
          });
    },
  },
  created() {
    this.getComics();
  }
};

</script>

<style lang="scss" scoped>
#searchPage {
    background-color: rgb(193, 225, 231);
}
</style>
