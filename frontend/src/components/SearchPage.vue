<template>
    <div id="searchPage" class="container-fluid rounded py-2 shadow-sm">
<v-card>
        <v-container
          fluid
          grid-list-md
        >
          <v-layout row wrap>
            <v-flex
              v-for="comic in comics"
              :key="comic.id"
            >
              <v-card>
                <v-img
                  :src="comic.image"
                  height="200px"
                >
                  <v-container
                    fill-height
                    fluid
                    pa-2
                  >
                    <v-layout fill-height>
                      <v-flex xs12 align-end flexbox>
                        <span class="headline white--text" v-text="comic.title"></span>
                      </v-flex>
                    </v-layout>
                  </v-container>
                </v-img>
              </v-card>
            </v-flex>
          </v-layout>
        </v-container>
      </v-card>
    </div>
</template>

<script>

import apiCalls from '@/apiCalls';

export default {
props: {
  searchComicName: String,
  searchIssueNumber: String

},

    data() {
    return {
      comics: []
      
    };
    },
    methods: {
    getComics(){
            apiCalls.marvelGet(`/comics?title=${this.searchComicName}&issueNumber=${this.searchIssueNumber}`)
            .then(parsedData => this.comics = parsedData.data.results);
        }
  }
};

</script>

<style lang="scss" scoped>
#searchPage {
    background-color: rgb(193, 225, 231);
}
</style>
