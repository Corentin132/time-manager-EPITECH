<script setup lang="ts">
import { ref, Ref } from "vue"

const holiday: Ref<{}> = ref({})

const SubmitHoliday = () => {
    console.log("Submited Holiday=", holiday.value)
}
</script>
<template>
    <div class="container-calendar-part">
        <h4 class="calendar-title">My calendar</h4>
        <q-date v-model="holiday" color="positive" range multiple minimal today-btn flat />
        <button @click="SubmitHoliday" type="button" class="calendar-btn">Add day off</button>
    </div>
</template>
<style lang="scss">
.container-calendar-part {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;

    font-family: "Poppins", sans-serif;
    width: 363px;

    border-radius: 14px;
    margin-top: 20px;
    .q-date__today {
        background-color: #0154d6;
        color: #fffefa;
    }
    .calendar-title {
        margin-left: 20px;
        color: #000;
        font-family: "Poppins", sans-serif;
        font-size: 16px;
        font-style: normal;
        font-weight: 600;
        line-height: normal;
        text-align: left;
        width: 100%;
    }
    .calendar-btn {
        display: flex;
        justify-content: center;
        align-items: center;
        width: 121px;
        height: 52px;
        border-radius: 10px;
        background: #ffc5c4;

        color: #fffefa;

        font-family: "Poppins", sans-serif;
        font-size: 16px;

        font-weight: 600;
        margin: 20px;
        outline: none;
    }
    .calendar-btn:hover {
        background-color: #fb180e;
    }
}
</style>
