<script lang="ts">
import { Bar } from "vue-chartjs"
import { Chart as ChartJS, Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale } from "chart.js"
// import { computed, defineComponent, ref } from "vue"

const worked_time = [1, 0, 0, 2, 1]
const label = ["J.M", "S.N", "F.H", "J.C", "G.P"]

ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale)

export default {
    name: "BarChart",
    components: { Bar },
    data() {
        return {
            chartData: {
                labels: label,
                datasets: [
                    {
                        data: worked_time,
                        backgroundColor: ["#FFC5C4"],
                        label: "Additional hour",
                        borderRadius: [10],
                    },
                ],
            },

            chartOptions: {
                responsive: true,
                plugins: {
                    legend: {
                        position: "bottom",

                        labels: {
                            color: "#00000",
                            font: {
                                familly: "Poppins",
                            },
                        },
                    },
                },
                scales: {
                    y: {
                        grid: {
                            lineWidth: 1,
                            color: "#000",
                        },
                        stacked: true,
                        ticks: {
                            color: "#000",
                            font: {
                                weight: 600,
                            },
                        },
                    },
                    x: {
                        grid: {
                            //   drawOnChartArea: false,
                            //   lineWidth: 0,
                            display: false,
                            circular: true,
                            color: "rgba(0,0,0,0)",
                            tickColor: "rgba(0,0,0,0)",
                            offset: true,
                            z: 0,
                        },
                        stacked: true,
                        ticks: {
                            color: "#000",
                            font: {
                                weight: 600,
                            },
                        },
                    },
                },
            },
        }
    },
}
</script>
<template>
    <div class="recap-graph">
        Additional hours
        <Bar id="my-chart-id" :options="chartOptions" :data="chartData" />
    </div>
</template>

<style lang="scss">
.recap-graph {
    font-size: 18px;
    background: #f8f8f8;
    border-radius: 10px;
    color: black;
    text-align: left;
    font-family: "Poppins", sans-serif;
    font-weight: 700;
    padding: 15px 10px;
    margin: 10px;
    width: 363px;
    height: 220px;
}
</style>
