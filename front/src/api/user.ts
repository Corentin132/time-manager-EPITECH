import { User, Response, Register } from "../types/users"
import axios from "axios"

const baseUrl = "/api/users"
const currentUserRoute = "/api/user"
const axiosConfig = {
    headers: {
        "Content-Type": "application/json",
    },
}

export async function get_user_by_id(id: number) {
    await axios
        .get(`${baseUrl}/${id}`, axiosConfig)
        .then((res: { data: User }) => {
            return res.data
        })
        .catch((err) => {
            return err
        })
}

export function is_user_logged_in() {
    return axios
        .get(`${currentUserRoute}`, axiosConfig)
        .then((res) => {
            return !!res.data.data
        })
        .catch(() => {
            return false
        })
}

export async function get_current_user() {
    return axios.get(`${currentUserRoute}`, axiosConfig).then((res) => {
        return res.data.data
    })
}
export function get_all_user() {
    return axios.get(`${baseUrl}`, axiosConfig).then((res) => {
        return res.data.data
    })
}

export async function create_user(user: Register) {
    await axios
        .post(`${baseUrl}/register`, user, axiosConfig)
        .then((res) => {
            return res.data
        })
        .catch((err) => {
            return err
        })
}
export function delete_user(id: string) {
    return axios
        .delete(`${baseUrl}/${id}`, axiosConfig)
        .then((res) => {
            return res.data
        })
        .catch((err) => {
            return err
        })
}
export function changer_user_role(user: User, id: string) {
    return axios
        .put(`/api/admin/${id}`, user, axiosConfig)
        .then((res) => {
            return res.data
        })
        .catch((err) => {
            return err
        })
}

export async function reset_password(password: string) {
    return axios
        .post(`${baseUrl}/reset_password`, password, axiosConfig)
        .then((res) => {
            return res
        })
        .catch((err) => {
            return err
        })
}

export function log_in(user: any) {
    return axios
        .post(`${baseUrl}/log_in`, user, axiosConfig)
        .then((res: { data: Response; status: number }) => {
            return res
        })
        .catch((err) => {
            return err
        })
}
export async function log_out() {
    await axios
        .delete(`${baseUrl}/log_out`, axiosConfig)
        .then((res) => {
            return res.data
        })
        .catch((err) => {
            return err
        })
}
