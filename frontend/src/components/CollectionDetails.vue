<template>
    <div id="collectionDetails" class="container-fluid rounded py-2 shadow-sm">
        <vue-headful :title="'ZapBoomPow - ' + title" />
    </div>
</template>

<script>
export default {
    data() {
        return {
            title: this.$route.params.id,
        }
    }

}
</script>

<style lang="scss" scoped>
#collectionDetails {
    background-color: rgb(193, 225, 231);
}
</style>

