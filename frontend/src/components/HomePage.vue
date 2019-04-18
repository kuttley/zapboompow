<template>
  <div id="home" class="container-fluid">
    <vue-headful title="ZapBoomPow - Home" />
    <v-dialog v-model="dialog" persistent max-width="600px">
      <v-card>
        <v-card-title>
          <span class="headline">Welcome to Zap Boom Pow!<img src="@/assets/logo.png" width="100px" alt="zapboompow"> <br>Search and organize your dream Marvel Comics collection! </span>
        </v-card-title>
        <v-card-text>
          <h2>Terms and Conditions ("Terms")</h2>
            <p>Last updated: April 18, 2019</p>
            <p>Please read these Terms and Conditions ("Terms", "Terms and Conditions") carefully before using the http://www.zapboompow.com website (the "Service") operated by Zap Boom Pow ("us", "we", or "our").</p>
            <p>Your access to and use of the Service is conditioned on your acceptance of and compliance with these Terms. These Terms apply to all visitors, users and others who access or use the Service.</p>
            <p>By accessing or using the Service you agree to be bound by these Terms.</p>
          <h2>Accounts</h2>
            <p>When you create an account with us, you must provide us information that is accurate, complete, and current at all times. Failure to do so constitutes a breach of the Terms, which may result in immediate termination of your account on our Service.</p>
            <p>You are responsible for safeguarding the password that you use to access the Service and for any activities or actions under your password, whether your password is with our Service or a third-party service.</p>
            <p>You agree not to disclose your password to any third party. You must notify us immediately upon becoming aware of any breach of security or unauthorized use of your account.</p>
          <h2>Links To Other Web Sites</h2>
            <p>Our Service may contain links to third-party web sites or services that are not owned or controlled by Zap Boom Pow.</p>
            <p>Zap Boom Pow has no control over, and assumes no responsibility for, the content, privacy policies, or practices of any third party web sites or services. You further acknowledge and agree that Zap Boom Pow shall not be responsible or liable, directly or indirectly, for any damage or loss caused or alleged to be caused by or in connection with use of or reliance on any such content, goods or services available on or through any such web sites or services.</p>
            <p>We strongly advise you to read the terms and conditions and privacy policies of any third-party web sites or services that you visit.</p>
          <h2>Termination</h2>
            <p>We may terminate or suspend access to our Service immediately, without prior notice or liability, for any reason whatsoever, including without limitation if you breach the Terms.</p>
            <p>All provisions of the Terms which by their nature should survive termination shall survive termination, including, without limitation, ownership provisions, warranty disclaimers, indemnity and limitations of liability.</p>
            <p>We may terminate or suspend your account immediately, without prior notice or liability, for any reason whatsoever, including without limitation if you breach the Terms.</p>
            <p>Upon termination, your right to use the Service will immediately cease. If you wish to terminate your account, you may simply discontinue using the Service.</p>
            <p>All provisions of the Terms which by their nature should survive termination shall survive termination, including, without limitation, ownership provisions, warranty disclaimers, indemnity and limitations of liability.</p>
          <h2>Governing Law</h2>
            <p>These Terms shall be governed and construed in accordance with the laws of Ohio, United States, without regard to its conflict of law provisions.</p>
            <p>Our failure to enforce any right or provision of these Terms will not be considered a waiver of those rights. If any provision of these Terms is held to be invalid or unenforceable by a court, the remaining provisions of these Terms will remain in effect. These Terms constitute the entire agreement between us regarding our Service, and supersede and replace any prior agreements we might have between us regarding the Service.</p>
          <h2>Changes</h2>
            <p>We reserve the right, at our sole discretion, to modify or replace these Terms at any time. If a revision is material we will try to provide at least 30 days notice prior to any new terms taking effect. What constitutes a material change will be determined at our sole discretion.</p>
            <p>By continuing to access or use our Service after those revisions become effective, you agree to be bound by the revised terms. If you do not agree to the new terms, please stop using the Service.</p>
          <h2>Contact Us</h2>
            <p>If you have any questions about these Terms, please contact us.</p>
        </v-card-text>
        
        <v-btn color="blue darken-1" flat @click="dialogAccept()">I Agree</v-btn>
      </v-card>
      
    </v-dialog>
    <div class="row wrap justify-content-between">
    
      <div id="main" class="col col-lg-auto col-12 mb-3 rounded pt-2 shadow-sm">
        <div class="row ml-1 mb-2">
          <v-icon color="purple" class="mr-1">fiber_new</v-icon>
          <h2 class="mb-0">Recent Comic Releases</h2>
        </div>

        <v-carousel hide-delimiters height="290" dark class="my-3 pt-3">
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
        <div class="row justify-center mb-2">
          <v-icon color="green darken-1" class="mr-1">info</v-icon>
          <h3 class="mb-0">All Collections Stats</h3>
        </div>
        <v-divider class="my-1"></v-divider>
        <table class="table ml-2">
            <tr class="subheading"> {{ stats.collectionsCount }} total collections </tr>
            <tr class="subheading"> {{ stats.publicCollectionsCount }} public collections created </tr>
            <tr class="subheading"> {{ stats.comicsCount }} comics searched </tr>
            <tr class="subheading"> {{ stats.comicsInCollections }} total comics in collections </tr>
            <tr class="subheading"> {{ stats.uniqueComicsInCollections }} unique comics in collections </tr>
            <tr class="subheading"> {{ stats.usersCount }} total users </tr>
            <tr class="subheading"> {{ stats.premiumUsersCount }} premium users </tr>
        </table>
      </div>
    </div>

    <div class="row">    
      <div id="featured" class="col col-sm-auto rounded pt-2 shadow-sm">
        <div class="row ml-1 mb-2">
          <v-icon color="indigo lighten-1" class="mr-1">check_circle</v-icon>
          <h2 class="mb-0">Featured Collections</h2>
        </div>
        <collection-list :featuredCollections="true" />

        <div class="d-flex flex-column justify-content-sm-center align-items-md-end mb-3">
          <router-link to="/collections" tag="button" class="v-btn text-none success darken-2">View All</router-link>
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
      stats: [],
      dialog: (localStorage.getItem('DialogAccepted') != null ? false : true),
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
    },
    dialogAccept() {
      localStorage.setItem('DialogAccepted', 'true');
      this.dialog = false;
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
