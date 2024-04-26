import axios from "axios"

const baseUrl = "/api/workingtimes/"
const axiosConfig = {
    headers: {
        "Content-Type": "application/json",
    },
}

export async function get_all_workingtimes() {
    return axios
        .get(`${baseUrl}`, axiosConfig)
        .then((res) => res.data)
        .catch((err) => err)
}
export async function get_user_workingtimes(userId: string, start: string, end: string) {
    return axios
        .get(`${baseUrl}${userId}?start=${start}&end=${end}`, axiosConfig)
        .then((res) => res.data.data)
        .catch((err) => err)
}
