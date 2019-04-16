<template>
    <div id="searchPage" class="container-fluid rounded py-2 shadow-sm">
      <div v-if="loading">Loading...</div>
      <div v-else>
        <v-card>
          <v-container fluid grid-list-md>
            <v-layout row wrap>
              <v-flex v-for="comic in comics" :key="comic.id">
                <v-card>
                  <router-link :to="`/comic/${comic.id}`">
                    <v-img :src="comic.thumbnail.path + '/portrait_medium.' + comic.thumbnail.extension" height="200px" contain></v-img>
                    <v-card-title primary-title class="text-center justify-content-center">
                      <h4>{{ comic.title }}</h4>
                    </v-card-title>
                  </router-link>
                </v-card>
              </v-flex>
            </v-layout>
          </v-container>
        </v-card>
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
          .then((parsedData) => {
            this.comics = parsedData.data.data.results;
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
