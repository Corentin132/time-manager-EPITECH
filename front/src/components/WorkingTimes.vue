<script setup lang="ts">
import Calendar from "./calendar_calendar/calendar.vue"
import Todo from "./calendar_todo/todo.vue"

interface Today {
    num: number
    week: string
    month: string
}
const date = new Date()
const temp_month = date.toLocaleDateString("en-us", { month: "long" })

const day: Today = {
    num: date.getDate(),
    week: date.toLocaleDateString("en-us", { weekday: "long" }),
    month: temp_month.slice(0, 3),
}
</script>

<template>
    <div>
        <Todo :num="day.num" :month="day.month" :week="day.month"></Todo>
        <Calendar></Calendar>
    </div>
</template>

<style lang="scss" scoped>
div {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
}
</style>
