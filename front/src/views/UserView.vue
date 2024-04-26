<script setup lang="ts">
import HomePage from "../components/HomePage.vue"
import UserTopBar from "../components/user_profile/UserTopBar.vue"
import { ref , Ref, inject, computed} from "vue"
import { User } from "../types/users"
const default_user = ref<User>({
    id: "0",
    username: "",
    email: "",
    first_name: "",
    last_name: "",
    password: ""
})

const connected_user = inject<Ref<User>>("connected_user")

const user = computed(() => {
    if (connected_user?.value == null) {
        return default_user.value
    }
    return connected_user.value
})

</script>

<template>
    <main class="container">
        <UserTopBar :message="'Hello '+ user.first_name" />
        <HomePage class="widget" />
    </main>
</template>
