<template>
    <div id="createCollectPage" class="container rounded shadow-sm text-center">
        <h3>Create a new Collection</h3>
        <v-layout align-center justify-center column mt-3>
            <div>
                <form @submit.prevent="createCollection">
                    <v-text-field label="Collection Name" v-model="newCollection.collection_name" clearable name="collectionName" v-validate="'required'" box hide-details></v-text-field>

                    <v-checkbox v-model="newCollection.public_bool" label="Public"></v-checkbox>

                    <v-btn type='submit'>submit</v-btn>
                </form>
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
    },
}
</script>

<style lang="scss" scoped>
#createCollectPage {
    width: 100%;
    background-color: rgb(193, 225, 231);
}
</style>

