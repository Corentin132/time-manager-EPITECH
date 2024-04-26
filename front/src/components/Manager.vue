<script setup lang="ts">
import Calendar from "./manager_calendar/calendar.vue"
import Holiday from "./manager_holiday/graph.vue"
import Hours from "./manager_additionnal_hour/graph.vue"
import WeekResume from "./manager_week_resume/graph.vue"
import InputTask from "./manager_task_input/task.vue"

const SubmitTask = () => {
    alert("task submitted")
}
</script>
<template>
    <WeekResume></WeekResume>

    <Calendar></Calendar>
    <div class="wrapper-input-task">
        <InputTask title="To: " placeholder="Username" bg="#C0D3F5"></InputTask>
        <InputTask title="Your task " placeholder="Your task" bg="#CEE0D5"></InputTask>
        <button @click="SubmitTask" type="button" class="task-btn">Add day off</button>
    </div>

    <Holiday></Holiday>
    <Hours></Hours>
</template>

<style>
.user-container {
    display: flex;
    flex-direction: column;
    align-items: center;

    .container-my-stat {
        display: flex;
        flex-direction: column;
        width: 390px;
        height: 280px;
        margin: 20px 0;

        border-radius: 20px;
        border: 0.5px solid black;

        .my-stat {
            font-size: 20px;
            font-family: "Poppins", sans-serif;
            font-weight: 500;
            text-align: left;
            margin-left: 2vw;
            line-height: normal;
        }

        .wrapper-my-stat {
            display: flex;
            flex-direction: row;
        }
    }
}
</style>
