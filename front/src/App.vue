<script setup lang="ts">
import { /*RouterLink,*/ RouterView } from "vue-router"
import { ref, provide, Ref, computed } from "vue"
import { User } from "./types/users"
import { get_current_user } from "./api/user"
let connected_user = ref<User | null>(null)
const default_user = ref<User>({
    id: "0",
    username: "",
    email: "",
    first_name: "",
    last_name: "",
    password: "",
    role: "",
})

get_current_user()
    .then((res) => {
        connected_user.value = res
    })
    .catch((err) => {
        console.error(err)
    })
const user = computed(() => {
    if (connected_user?.value == null) {
        return default_user.value
    }
    return connected_user.value
})

provide<Ref<User>>("connected_user", user)
</script>

<template>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" />
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&family=Poppins:ital,wght@0,300;0,400;0,500;0,600;1,700&display=swap" rel="stylesheet" />
    <RouterView />
</template>

<style scoped>
.logo {
    height: 6em;
    padding: 1.5em;
    will-change: filter;
    transition: filter 300ms;
}
.logo:hover {
    filter: drop-shadow(0 0 2em #646cffaa);
}
.logo.vue:hover {
    filter: drop-shadow(0 0 2em #42b883aa);
}
</style>
