<script setup lang="ts">
interface Props {
    title: string
    placeholder: string
    bg: string
}
const props = defineProps<Props>()
</script>

<template>
    <div class="container-task">
        <p>{{ props.title }}</p>
        <input type="text" :placeholder="placeholder" class="input-task" />
    </div>
</template>

<style lang="scss" scoped>
.container-task {
    text-align: start;
    color: black;
    font-family: "Poppins", sans-serif;
    font-weight: 600;
    margin-bottom: 10px;

    .input-task {
        border: none;
        width: 316px;
        height: 52px;

        border-radius: 10px;
        color: white;
        background: v-bind("props.bg");
        outline: none;
        padding-left: 10px;
    }
    .input-task::placeholder {
        color: white;
    }
}
</style>
