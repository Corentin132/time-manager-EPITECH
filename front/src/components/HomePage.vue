<script setup lang="ts">
import Stat from "./user_stat/stat.vue"
import Timer from "./user_timer/timer.vue"
import Graph from "./user_graph/graph.vue"
</script>

<template>
    <div class="user-container">
        <Graph></Graph>
        <Timer></Timer>
        <div class="container-my-stat">
            <h2 class="my-stat">My Stats</h2>
            <div class="wrapper-my-stat">
                <Stat title="Congé restant" sub_title="days" number="3.5" color="#F0E3F7" bg="#C191E3"></Stat>
                <Stat title="Heures supp" sub_title="hours" number="4" color="#FFC5C4" bg="#FB180E"></Stat>
            </div>
        </div>
    </div>

</template>

<style lang="scss">
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
        border: 0.5px solid #0000;

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
