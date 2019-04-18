<template>
    <div id="publicCollections" class="container-fluid rounded pt-2 shadow-sm">
        <div class="row ml-1 mb-2">
            <v-icon color="green darken-1" class="mr-1">public</v-icon>
            <h2 class="mb-0">All Public Collections</h2>
        </div>
        <collection-list />
    </div>
</template>

<script>
import CollectionList from '@/components/CollectionList.vue';

export default {
    components: {
        CollectionList,
    }
}
</script>

<style lang="scss" scoped>
#publicCollections {
    background-color: rgb(193, 225, 231);
}
</style>

