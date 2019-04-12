<template>
  <div id="home" class="container">
    <div class="row justify-content-between mb-3">
      <div id="main" class="col col-sm-auto rounded pt-2 shadow-sm">
        <h2>Recent Comic Releases</h2>
        <v-carousel hide-delimiters height="250" dark class="mb-3">
          <v-carousel-item v-for="comic in newestReleases" v-bind:key="comic.id">
            <v-img :src="comic.thumbnail" height="216" contain></v-img>
            <h3 class="text-center">{{comic.title}}</h3>
          </v-carousel-item>

        </v-carousel>
      </div>
      <div id="sidebar" class="col col-sm-auto rounded pt-2 shadow-sm">
        <h5 class="text-center">All Collections Stats</h5>
      </div>
    </div>
    <div class="row">    
      <div id="featured" class="col col-sm-auto rounded pt-2 shadow-sm">
        <h3>Featured Collections</h3>
      </div>
    </div>

  </div>
</template>

<script>
const axios = require('axios');

const instance = axios.create({
  baseURL: 'https://gateway.marvel.com:443/v1/public/',
  headers: {
    'Content-Type': 'application/json',
  },
  params: {
    ts:`${process.env.VUE_APP_MARVEL_API_TS}`,
    apikey:`${process.env.VUE_APP_MARVEL_API_KEY}`,
    hash:`${process.env.VUE_APP_MARVEL_API_HASH}`
  }
});

export default {
  data() {
    return {
      newestReleases: [],
    }
  },
  methods: {
    getRecentComics() {
      if (localStorage.getItem('newestReleases') == null || (new Date().time() / 1000) - localStorage.getItem('newestReleasesTS') >= 86400 ) {
        instance.get('/comics?dateDescriptor=thisWeek&orderBy=-onsaleDate')
          .then((response) => {
            for (let result of response.data.data.results) {
              let comicInfo = {};
              comicInfo.id = result.id;
              comicInfo.title = result.title;
              comicInfo.thumbnail = result.thumbnail.path + '/portrait_incredible.' + result.thumbnail.extension;
              this.newestReleases.push(comicInfo);
            }
            localStorage.setItem('newestReleases', JSON.stringify(this.newestReleases));
            localStorage.setItem('newestReleasesTS', (new Date().time() / 1000));

            console.log(localStorage.getItem('newestReleases'));
          })
          .catch((err) => console.log(err));
      } else {
        this.newestReleases = JSON.parse(localStorage.getItem('newestReleases'));
      }
    }
  },
  computed: {

  },
  mounted() {
    this.getRecentComics();
  },
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="scss">
.container {
  margin-left: 0;
}

.v-carousel {
  box-shadow: none!important;
}

#home {
  #main {
    width: 75%;
    background-color: rgba(255, 255, 255, 0.4);
  }
  #sidebar {
    width: 20%;
    background-color: rgba(255, 255, 255, 0.4);
    * {
      background-color: rgba(255, 255, 255, 0);
    }
  }

  #featured {
    width: 100%;
    background-color: rgba(255, 255, 255, 0.4);
    * {
      background-color: rgba(255, 255, 255, 0);
    }
  }
}
</style>
