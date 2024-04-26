<script setup lang="ts">
import { log_in } from "../api/user"
import { Login } from "./../types/users"
import { ref } from "vue"
import router from "../router/index"
import { requiredPwd, requiredEmail } from "../utils/auth"
const email = ref("")
const password = ref("")

const isLoading = ref(false)

const checkEmail = () => {
    if (requiredEmail(email.value)) {
        return true
    }
    return " Please enter a valid email"
}
const checkPwd = () => {
    if (requiredPwd(password.value)) {
        return true
    }
    return "Please enter a valid  password, with minimum one Upper case , Lower caser, Number and a special character (@, #, $, %, ^, &, +, =, !)"
}

const handleConnect = async () => {
    isLoading.value = true
    const login: Login = {
        user: {
            email: email.value,
            password: password.value,
        },
    }

    try {
        const res = await log_in(login)
        if (res.status === 200) {
            router.push("/user")
        } else {
            alert("login failed")
        }
        isLoading.value = false
    } catch (e) {
        // console.log("ERROR = ", (e as Error).message)
        isLoading.value = false
    }
}
</script>

<template>
    <div>
        <q-avatar size="242px">
            <img src="../assets/logo-batman.svg" alt="" srcset="" />
        </q-avatar>

        <h1 class="title">Login</h1>
        <q-input class="input-text" color="secondary" outlined v-model="email" type="text" label="E-mail" clearable :rules="[checkEmail]"> </q-input>
        <q-input class="input-text" color="secondary" outlined v-model="password" type="password" label="Password" :rules="[checkPwd]">
            <template #append> </template>
        </q-input>
        <q-btn @click="handleConnect" label="Connect" type="submit" color="secondary" push hover="positive" :disable="isLoading">
            <q-spinner-dots v-if="isLoading" color="white" size="20px" />
        </q-btn>
    </div>
</template>
<style scoped>
.input-text {
    margin: 2vh 0vh;
}

.q-btn {
    padding: 1vh 2vh;
    margin: 2vh 0vh;
}
.title {
    letter-spacing: 0.15em;
}
</style>
