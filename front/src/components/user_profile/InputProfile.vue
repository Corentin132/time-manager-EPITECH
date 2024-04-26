<script setup lang="ts">
interface Props {
    title: string
    type?: string
    value: string
    bg: string
}

const props = defineProps<Props>()
</script>

<template>
    <div class="container-profile">
        <p>{{ props.title }}</p>
        <input :type="props.type" :value="props.value" class="inputProfile" />
    </div>
</template>

<style lang="scss" scoped>
.container-profile {
    display: flex;
    flex-direction: column;
    text-align: start;
    padding-left: 1vw;
    padding-right: 1vw;
    color: black;
    font-family: "Poppins", sans-serif;
    font-weight: 600;
    .inputProfile {
        align-self: center;
        width: 316px;
        height: 52px;
        flex-shrink: 0;
        border-radius: 10px;
        background: v-bind("props.bg");
        margin-bottom: 2vh;
    }
}
</style>
