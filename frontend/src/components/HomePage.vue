<template>
  <div id="home" class="container-fluid">
    <vue-headful title="ZapBoomPow - Home" />
    <div class="row wrap justify-content-between">

      <div id="main" class="col col-lg-auto col-12 mb-3 rounded pt-2 shadow-sm">
        <h2>Recent Comic Releases</h2>

        <v-carousel hide-delimiters height="290" dark class="my-3">
          <v-carousel-item v-if="loading"><h4 class="text-center">Loading...</h4></v-carousel-item>
          <v-carousel-item v-else v-for="comic in newestReleases" v-bind:key="comic.id">
            <router-link :to="`/comic/${comic.id}`">
              <v-img :src="comic.thumbnail" height="216" contain></v-img>
              <h4 class="text-center pt-2 grey--text text--darken-4">{{comic.title}}</h4>
            </router-link>
          </v-carousel-item>
        </v-carousel>
      </div>

      <div id="sidebar" class="col col-lg-auto col-12 mb-3 rounded pt-2 shadow-sm">
        <h3 class="text-center">All Collections Stats</h3>
        <table class="table" >
            <tr> {{ stats.collectionsCount }} number of collections </tr>
            <tr> {{ stats.comicsCount }} total comics searched </tr>
            <tr> {{ stats.usersCount }} number of users </tr>
            <tr> {{ stats.premiumUsersCount }} number of premium users </tr>
            <tr> {{ stats.publicCollectionsCount }} public collections created </tr>
        </table>
      </div>
    </div>

    <div class="row">    
      <div id="featured" class="col col-sm-auto rounded pt-2 shadow-sm">
        <h2>Featured Collections</h2>
        <collection-list :featuredCollections="true" />

        <div class="d-flex flex-column justify-content-sm-center align-items-md-end mb-3">
          <router-link to="/collections" tag="button" class="btn btn-lg btn-success">View All</router-link>
        </div>

      </div>
    </div>

  </div>
</template>

<script>
import apiCalls from '@/apiCalls';
import CollectionList from '@/components/CollectionList.vue';

export default {
  components: {
    CollectionList
  },
  data() {
    return {
      newestReleases: [],
      loading: true,
      stats: []
    }
  },
  methods: {
    getRecentComics() {

      if (localStorage.getItem('newestReleases') == null || (new Date().getTime() / 1000) - localStorage.getItem('newestReleasesTS') >= 86400 ) {
        apiCalls.marvelGet('/comics?dateDescriptor=thisWeek&orderBy=-onsaleDate')
          .then((response) => {
            for (let result of response.data.data.results) {
              let comicInfo = {};
              comicInfo.id = result.id;
              comicInfo.title = result.title;
              comicInfo.thumbnail = result.thumbnail.path + '/portrait_incredible.' + result.thumbnail.extension;
              this.newestReleases.push(comicInfo);
            }
            localStorage.setItem('newestReleases', JSON.stringify(this.newestReleases));
            localStorage.setItem('newestReleasesTS', (new Date().getTime() / 1000));
            this.loading = false;
          })
          .catch((err) => console.log(err));
      } else {
        this.newestReleases = JSON.parse(localStorage.getItem('newestReleases'));
        this.loading = false;
      }
    },

    getStats() {
      apiCalls.get(`/stats`)
      .then((response) => {
            this.stats = response.data;
            this.loading = false;
          });
    }
  },
  created() {
    this.getStats();
  },
  mounted() {
    this.getRecentComics();
  },
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="scss">

.v-carousel {
  box-shadow: none!important;
  background-image: url('../assets/background.png');
    background-position: center;
    background-size: cover;
}

#home {
  #main {
    width: 75%;
    background-color: rgb(193, 225, 231);
    
  }
  #sidebar {
    width: 20%;
    background-color: rgb(193, 225, 231);
  }

  #featured {
    width: 100%;
    background-color: rgb(193, 225, 231);
    
  }
}
</style>
