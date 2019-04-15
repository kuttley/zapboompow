<template>
    <div id="publicCollections" class="container-fluid rounded pt-2">
        <h2>All Public Collections</h2>
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

