<template>
    <collection-details v-on:reload="reload" :key="componentKey" />
</template>

<script>
import CollectionDetails from '@/components/CollectionDetails';
export default {
    data() {
        return {
            componentKey: 0
        }
    },
    components: {
        CollectionDetails,
    },
    methods: {
        reload() {
            this.componentKey += 1;
        }
    }
}
</script>

<style>

</style>
