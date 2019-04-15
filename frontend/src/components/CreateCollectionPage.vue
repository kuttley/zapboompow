<template>
    <div id="createCollectPage" class="container-fluid rounded shadow-sm text-center py-2">
        <vue-headful title="ZapBoomPow - Create New Collection" />
        <h3>Create a new Collection</h3>
        <v-layout align-center justify-center column mt-3>
            <div v-if="!this.loading">
                <div>
                    <div v-if="this.collectionCreatable">
                        <form @submit.prevent="createCollection">
                            <v-text-field label="Collection Name" v-model="newCollection.collection_name" clearable name="collectionName" v-validate="'required'" box hide-details></v-text-field>

                            <v-checkbox v-model="newCollection.public_bool" color="#21272d" hide-details label="Public"></v-checkbox>

                            <v-btn type='submit'>submit</v-btn>
                        </form>
                    </div>
                    <div v-else>
                        <h4 class="font-weight-light">You've reached the maximum amount of collections for your account.</h4>
                        <h5 class="font-weight-light">Upgrade to Premium for unlimited collections and more!</h5>
                        <v-btn color="warning">Learn more about Premium!</v-btn>
                    </div>
                </div>
            </div>
            <div v-else>
                <h5>Loading...</h5>
            </div>
        </v-layout>
    </div>
</template>

<script>
import auth from '@/auth';
import apiCalls from '@/apiCalls';

export default {
    name: "create-collection-page",
    data() {
        return {
            currUser: auth.getUser(),
            collectionCreatable: true,
            loading: true,
            newCollection: {
                collection_name: '',
                public_bool: true,
            },
        }
    },
    methods: {
        createCollection() {
            console.log(this.currUser);

            apiCalls.post('/collection/', this.newCollection)
                .then(() => {
                    this.$router.push('/user/' + this.currUser.uid);
                });
        },
        canCreateCollection() {
            if (this.currUser.rol == "standard") {
                apiCalls.get(`/collection/all/${this.currUser.uid}`)
                    .then((response) => {
                        if (response.data.length > 0) {
                            this.collectionCreatable = false;
                            this.loading = false;
                        } else {
                            this.collectionCreatable = true;
                            this.loading = false;
                        }
                    });
            } else {
                this.collectionCreatable = true;
                this.loading = false;
            }
        }
    },
    created() {
        this.canCreateCollection();
        console.log(this.collectionCreatable);
    }
}
</script>

<style lang="scss" scoped>
#createCollectPage {
    width: 100%;
    background-color: rgb(193, 225, 231);
}
</style>

