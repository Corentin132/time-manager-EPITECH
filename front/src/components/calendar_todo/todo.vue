<script setup lang="ts">
const props = defineProps(["num", "month", "week"])
</script>
<template>
    <div class="todo-container">
        <div class="date-container">
            <div class="wrapper-date">
                <span class="number-date">{{ props.num }}</span>
                <p class="month-date">{{ props.month }}</p>
            </div>
            <span class="stroke-date"></span>
            <p class="day-date">{{ props.week }}</p>
        </div>
        <div class="task-container">No task added by</div>
    </div>
</template>

<style lang="scss">
.todo-container {
    display: flex;

    align-items: center;
    justify-content: center;
    flex-direction: column;
    border-radius: 14px;
    background: #f8f8f8;
    font-family: "Poppins", sans-serif;

    width: 363px;
    height: 335px;

    .task-container {
        width: 327px;
        height: 222px;
        border-radius: 14px;
        border: 1px solid #000;
        display: flex;
        justify-content: center;
        align-items: center;
    }
    .date-container {
        display: flex;
        align-items: center;
        font-weight: 600;
        width: 327px;
        text-align: left;
        .stroke-date {
            width: 2px;
            height: 58px;
            background: black;
            margin: 2px 20px;
        }
        .wrapper-date {
            .number-date {
                font-size: 36px;
            }

            .month-date {
                font-size: 16px;
                color: #8f8f8f;
            }
        }
        .day-date {
            font-size: 20px;
        }
    }
}
</style>
