<script lang="ts">
import { Bar } from "vue-chartjs"
import { Chart as ChartJS, Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale } from "chart.js"
import { User } from "../../types/users"
import { Ref, inject } from "vue"
import { get_user_workingtimes } from "../../api/workinTimes"
import { WorkingTimes } from "../../types/workingTimes"

let worked_time = [0, 0, 0, 0, 0]
let additional_hour = [0, 0, 0, 0, 0]

ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale)

export default {
    name: "BarChart",
    components: { Bar },

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
        async get_user_stat() {
            try {
                const user = inject<Ref<User>>("connected_user")
                const currentDate = new Date()
                const start = this.getMondayOfCurrentWeek(currentDate)
                const end = this.getSundayOfCurrentWeek(currentDate)
                if (user?.value?.id) {
                    const res: WorkingTimes[] = await get_user_workingtimes(user?.value.id, start, end)
                    for (let i = 0; i < 8; i++) {
                        worked_time[i] = this.calculateDuration(res[i].start, res[i].end)
                        if (worked_time[i] > 7) {
                            additional_hour[i] = worked_time[i] - 7
                            worked_time[i] = 7
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
            } catch (error) {
                console.error("Failed to get timer status", error)
                alert("Failed to get timer status")
            }
        },
    },
    mounted() {
        // Appeler la fonction lorsque le composant est monté
        this.get_user_stat()
    },
    data() {
        return {
            chartData: {
                labels: ["Mon.", "Tue.", "Wed.", "Thu.", "Fry.", "Sat.", "Sun."],
                datasets: [
                    {
                        data: worked_time,
                        backgroundColor: ["#c0d3f5"],
                        label: "Worked time",
                        borderRadius: [10],
                    },
                    {
                        label: "Additional hour",
                        data: additional_hour,
                        backgroundColor: ["#ffc5c4"],
                        borderRadius: [10],
                        // borderSkipped: false,
                    },
                ],
            },

            chartOptions: {
                responsive: true,
                plugins: {
                    legend: {
                        position: "bottom",

                        labels: {
                            color: "#C0D3F5",
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
                            color: "#C0D3F5",
                        },
                        stacked: true,
                        ticks: {
                            color: "#C0D3F5",
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
                            color: "#C0D3F5",
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
        Work resume
        <Bar id="my-chart-id" :options="chartOptions" :data="chartData" ref="myChart" />
    </div>
</template>

<style lang="scss">
.recap-graph {
    background: #0154d6;
    border-radius: 10px;
    color: #c0d3f5;
    text-align: left;
    font-family: "Poppins", sans-serif;
    font-weight: 700;
    padding: 15px 10px;
    margin: 10px 0.5px;
    width: 363px;
    height: 190px;
}
</style>
