<template>
    <collection-list :public="searchingPublic"  />
</template>

<script>
import CollectionList from '@/components/CollectionList.vue';

export default {
    props: {
        searchingPublic: Boolean,
    },
    components: {
        CollectionList,
    }
}
</script>

<style>

</style>
