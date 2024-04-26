<script setup lang="ts">
import { Ref, inject, ref } from "vue"
import { get_timer_status, create_clock_user } from "../../api/clocking"
import { ClockUser } from "../../types/clock"
import { User } from "../../types/users"
let isClicked = ref(true)
let btn = isClicked.value ? "Start" : "Stop"
const user = inject<Ref<User>>("connected_user")
const checkTimerStatus = async () => {
    try {
        if (user?.value.id) {
            const res: ClockUser = await get_timer_status(user?.value.id)
            btn = res.status ? "Stop" : "Start"
            isClicked.value = !res.status
        }
    } catch {
        alert("failed to get timer status")
    }
}
const handleClick = async () => {
    try {
        if (user?.value.id) {
            await create_clock_user(user?.value.id)
            checkTimerStatus()
        }
    } catch {
        alert("Failed to start the timer ")
    }
}
checkTimerStatus()
</script>

<template>
    <div class="timer-container">
        <h2 class="timer-title">Work Time</h2>
        <div class="wrapper-timer">
            <button class="timer" :class="{ active: isClicked }" @click="handleClick">{{ btn }}</button>
            <!-- <q-btn class="break" label="Custom my break" color="info"></q-btn> -->
        </div>
    </div>
</template>

<style lang="scss">
.timer-container {
    display: flex;
    flex-direction: column;
    justify-content: center;
    width: 363px;
    height: 348px;
    border-radius: 14px;
    background: #f8f8f8;
    .timer-title {
        color: #000;

        text-align: center;
        font-family: "Poppins", sans-serif;
        font-size: 24px;
        font-style: normal;
        font-weight: 600;
        line-height: normal;
    }
    .wrapper-timer {
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;

        .timer {
            background: #fb180e;
            border: solid 7px #ffc5c4;
            width: 172px;
            height: 172px;
            border-radius: 100%;
            color: #ffc5c4;

            text-align: center;
            font-family: "Poppins", sans-serif;
            font-size: 24px;
            font-style: normal;
            font-weight: 600;
            line-height: normal;
            margin: 18px;
            outline: none;
            transition: 0.2s;
        }

        .active {
            background: #11672a;
            transition: 0.2s;
            border: solid 7px #cee0d5;
            width: 172px;
            height: 172px;
            border-radius: 100%;
            color: #cee0d5;

            text-align: center;
            font-family: "Poppins", sans-serif;
            font-size: 24px;
            font-style: normal;
            font-weight: 600;
            line-height: normal;
            margin: 18px;
            outline: none;
        }
        .break {
            color: red;
        }
    }
}
</style>
