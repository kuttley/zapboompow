<template>
    <div>
        <user-page :profileID="$attrs.id" />
    </div>
</template>

<script>
import UserPage from '@/components/UserPage.vue';

export default {
    props: {
        profileID: String,
    },
    components: {
        UserPage,
    },
}
</script>

<style>

</style>
