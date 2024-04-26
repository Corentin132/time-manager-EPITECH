<script lang="ts">
import { Chart as ChartJS, Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale } from "chart.js"
ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale)
import { Bar } from "vue-chartjs"
import { Ref, inject } from "vue"
import { User } from "../../types/users"
import { get_manager_stat } from "../../api/clocking"
import { WorkingTimes } from "../../types/workingTimes"
import { get_user_workingtimes } from "../../api/workinTimes"

let worked_time = [0, 0, 0, 0, 0]
let label = [""]

export default {
    props: ["chartData", "chartOptions"],

    methods: {
        calculateDuration(start: string, end: string): number {
            const startTime = new Date(start).getTime()
            const endTime = new Date(end).getTime()
            const durationInHours = (endTime - startTime) / (1000 * 60 * 60)
            if (isNaN(startTime) || isNaN(endTime)) {
                throw new Error("Invalid date format")
            }

            return durationInHours
        },
        getMondayOfCurrentWeek(date: Date): string {
            const dayOfWeek = date.getDay() // Récupérer le jour de la semaine (0 = dimanche, 1 = lundi, ..., 6 = samedi)
            const daysUntilMonday = dayOfWeek === 0 ? 6 : dayOfWeek - 1 // Nombre de jours jusqu'à lundi
            const mondayOfWeek = new Date(date.getTime() - daysUntilMonday * 24 * 60 * 60 * 1000)
            mondayOfWeek.setHours(0, 0, 0, 0) // Définir l'heure à 00:00:00
            const formattedMonday = mondayOfWeek.toISOString()
            return formattedMonday
        },
        getSundayOfCurrentWeek(date: Date): string {
            const dayOfWeek = date.getDay() // Récupérer le jour de la semaine (0 = dimanche, 1 = lundi, ..., 6 = samedi)
            const daysUntilSunday = dayOfWeek === 0 ? 0 : 7 - dayOfWeek // Nombre de jours jusqu'à dimanche
            const sundayOfWeek = new Date(date.getTime() + daysUntilSunday * 24 * 60 * 60 * 1000)
            sundayOfWeek.setHours(23, 59, 59, 999) // Définir l'heure à 23:59:59.999
            const formattedSunday = sundayOfWeek.toISOString()

            return formattedSunday
        },
        async get_all_users_stat() {
            try {
                const user = inject<Ref<User>>("connected_user")

                if (user?.value?.id) {
                    const idTest = "fd876955-1a4e-4236-9321-a44fda6684c9"
                    // const res = await get_manager_stat(user.value.id)
                    const res = await get_manager_stat(idTest)

                    if (res) {
                        const currentDate = new Date()
                        const start = this.getMondayOfCurrentWeek(currentDate)
                        const end = this.getSundayOfCurrentWeek(currentDate)
                        for (let i = 0; i < res.length; i++) {
                            console.log(res[i].id, start, end)
                            const res2: WorkingTimes[] = await get_user_workingtimes(res[i].id, start, end)
                            console.log("res2", res2)
                            if (res2) {
                                for (let j = 0; j < 8; j++) {
                                    if (res2[j] === undefined) {
                                        worked_time[i] = 1
                                    } else {
                                        worked_time[i] += this.calculateDuration(res2[j].start, res2[j].end)
                                    }
                                }
                                label[i] = res[i].first_name[0] + "." + res[i].last_name[0]
                            }
                        }
                        if (this.$refs.myChart) {
                            const chartComponent = this.$refs.myChart as typeof Bar // Utilisation de 'any' pour contourner le problème
                            if (chartComponent.chart) {
                                // Assurez-vous que 'chart' existe sur le composant
                                chartComponent.chart.update(this.chartData, this.chartOptions)
                            }
                        } else {
                            alert("Failed to load your data")
                        }
                    }
                }
            } catch (error) {
                console.error("Failed to get timer status", error)
                alert("Failed to get timer status")
            }
        },
    },
    mounted() {
        this.get_all_users_stat()
    },
    name: "BarChart",
    components: { Bar },
    data() {
        return {
            title: "Week resume",
            toggle: false,
            chartData: {
                labels: label,
                datasets: [
                    {
                        data: worked_time,
                        backgroundColor: ["#CEE0D5"],
                        label: "Work hours",
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
                                familly: "Poppins, sans-serif",
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
        {{ title }}
        <Bar id="my-chart-id" :options="chartOptions" :data="chartData" ref="myChart" />
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
