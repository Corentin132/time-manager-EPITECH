<script setup lang="ts">
import { Ref, inject, ref } from "vue"
import { User } from "../../types/users"
import router from "../../router"
import { log_out } from "../../api/user"

let connected_user = inject<Ref<User>>("connected_user")
interface Props {
    message: string
}
const props = defineProps<Props>()
const default_user = ref<User>({
    id: "0",
    username: "name",
    email: "mail",
    first_name: "first name",
    last_name: "last name",
    password: "",
    avatar: "https://cdn.quasar.dev/img/boy-avatar.png",
})

if (connected_user == null) {
    connected_user = default_user
}
const home_handleClick = () => {
    router.push("/user")
}
const profile_handleClick = () => {
    router.push("/profile")
}
const time_handleClick = () => {
    router.push("/time")
}
const manager_handleClick = () => {
    router.push("/manager")
}
const admin_handleClick = () => {
    router.push("/admin")
}
const log_out_handleClick = () => {
    log_out()
    router.push("/")
}
</script>

<template>
    <div class="container-topBar">
        {{ props.message }}
        <q-btn round  style="background-color: rgb(1, 1, 44);">
            <q-avatar size="5vh">
                <!-- <img v-if="connected_user != null" :src="connected_user.avatar" alt="" />
                <img v-else :src="default_user.avatar" alt="" /> -->
                <img src="../../assets/Batsignal.png" alt="" />
            </q-avatar>
            <q-menu auto-close>
                <q-list style="min-width: 100px">
                    <q-item clickable @click="home_handleClick">
                        <q-item-section>Home</q-item-section>
                    </q-item>
                    <q-separator />
                    <q-item clickable @click="profile_handleClick">
                        <q-item-section>Profile</q-item-section>
                    </q-item>
                    <q-separator />
                    <q-item clickable @click="time_handleClick">
                        <q-item-section>Time</q-item-section>
                    </q-item>
                    <q-separator />
                    <q-item clickable v-if="connected_user?.role == 'manager'" @click="manager_handleClick">
                        <q-item-section>Manager View</q-item-section>
                    </q-item>
                    <q-separator />
                    <q-item clickable v-if="connected_user?.role == 'admin'" @click="admin_handleClick">
                        <q-item-section>Admin Panel</q-item-section>
                    </q-item>
                    <q-separator />
                    <q-item clickable @click="log_out_handleClick">
                        <q-item-section>Log Out</q-item-section>
                    </q-item>
                </q-list>
            </q-menu>
        </q-btn>
    </div>
</template>

<style lang="scss">
.center_avatar {
    display: flex;
    flex-direction: row;
    // justify-content: start;
    align-self: center;
}
.container-topBar {
    text-align: start;
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: space-between;
    // padding: 1vh;

}
</style>
