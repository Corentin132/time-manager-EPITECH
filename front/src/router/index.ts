import { createRouter, createWebHistory } from "vue-router"
import login from "../views/LoginView.vue"
import register from "../views/RegisterView.vue"
import user from "../views/UserView.vue"
import profile from "../views/ProfileView.vue"
import admin from "../views/AdminView.vue"
import time from "../views/Calendar.vue"
import manager from "../views/ManagerView.vue"
import { get_current_user, is_user_logged_in } from "../api/user"
import { ref } from "vue"
import { User } from "../types/users"
let connected_user = ref<User | null>(null)
get_current_user().then((res) => {
    connected_user.value = res
}).catch((err) => {
    console.error(err)
})

const router = createRouter({
    history: createWebHistory(import.meta.env.BASE_URL),
    routes: [
        {
            path: "/",
            name: "login",
            component: login,
        },
        {
            path: "/register",
            name: "register",
            component: register,
        },
        {
            path: "/user",
            name: "user",
            component: user,
        },
        {
            path: "/profile",
            name: "profile",
            component: profile,
        },
        {
            path: "/time",
            name: "time",
            component: time,
        },
        {
            path: "/manager",
            name: "manager",
            component: manager,
        },
        {
            path: "/admin",
            name: "admin",
            component: admin,
        },
    ],
})

router.beforeEach(async (to) => {
    console.log(to.name)
    try {
        const res = await is_user_logged_in()
        console.log("res --> " + res)
        if (res !== true && (to.name == "user" || to.name == "profile" || to.name == "time")) {
            return { name: 'login' }
        }
        if (res == true && (to.name == "login" || to.name == "register")) {
            return { name: 'user' }
        }
        if (to.name == "manager" && connected_user.value?.role !== "manager") {
            return { name: 'user' }
        }
        if (to.name == "admin" && connected_user.value?.role == "admin") {
            return { name: 'admin' }
        }
        if (to.name == "admin" && connected_user.value?.role !== "admin") {
            return { name: 'user' }
        }
    } catch (err) {
        console.log(err)
        return { name: 'login' }
    }
})


export default router
