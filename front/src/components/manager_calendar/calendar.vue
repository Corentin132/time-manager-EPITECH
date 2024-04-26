<script setup lang="ts">
import { ref, Ref } from "vue"

const holiday: Ref<{}> = ref({})
const dayOff = (date: string) => {
    // GetAllDayOFF => return tout les congés des employés
    if (date === "2023/11/01" || date === "2023/11/05" || date === "2023/11/06" || date === "2023/11/09" || date === "2023/11/23") {
        return true
    }
    return false
}
</script>
<template>
    <div class="container-calendar-part">
        <h4 class="calendar-title">My calendar</h4>
        <q-date v-model="holiday" color="positive" minimal today-btn flat :events="dayOff" :event-color="'orange'" />
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
