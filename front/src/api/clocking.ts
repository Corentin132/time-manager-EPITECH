import { ClockUser } from "../types/clock"
import axios from "axios"
const baseUrl = "/api/clocks/"
const axiosConfig = {
    headers: {
        "Content-Type": "application/json",
    },
}

export function create_clock_user(id: string) {
    return (
        axios
            .post(`${baseUrl}${id}`, "", axiosConfig)
            // .then((res) => res.data)
            .catch((err) => {
                return err
            })
    )
}
export function get_timer_status(id: string) {
    return axios
        .get(`${baseUrl}${id}`, axiosConfig)
        .then((res: { data: { data: ClockUser } }) => res.data.data)
        .catch((err) => {
            return err
        })
}

export function get_manager_stat(id: string) {
    return axios
        .get(`/api/manager/${id}`, axiosConfig)
        .then((res) => {
            return res.data.data
        })
        .catch((err) => {
            return err
        })
}
