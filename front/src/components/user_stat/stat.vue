<script setup lang="ts">
const props = defineProps(["title", "number", "sub_title", "color", "bg"])
</script>

<template>
    <div class="container-stat">
        <h4 class="title-stat">{{ props.title }}</h4>
        <div class="wrapper-stat">
            <span class="number-stat">{{ props.number }}</span>
            <p class="sub_title-stat">{{ props.sub_title }}</p>
        </div>
    </div>
</template>
<style lang="scss">
.container-stat {
    color: v-bind("props.color");
    font-family: "Poppins", sans-serif;
    font-weight: 600;
    border-radius: 14px;
    background: v-bind("props.bg");
    width: 174.022px;
    height: 176px;
    margin: 10px 10px;
    .title-stat {
        font-size: 16px;
        margin: 0;
        width: 100%;
        text-align: left;
        font-weight: 700;
        margin-left: 10px;
    }
    .wrapper-stat {
        display: flex;
        flex-direction: column;
        justify-content: center;

        .number-stat {
            font-size: 48px;
        }
        .sub_title-stat {
            font-size: 16px;
        }
    }
}
</style>
