<template>
    <comic-details />
</template>

<script>
import ComicDetails from '@/components/ComicDetails.vue';

export default {
    props: {
        comicID: String,
    },
    components: {
        ComicDetails,
    }
}
</script>

<style lang="scss" scoped>
</style>

