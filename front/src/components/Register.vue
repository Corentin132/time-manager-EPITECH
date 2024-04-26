<script setup lang="ts">
import { ref } from "vue"
import router from "../router"
import { create_user } from "../api/user"
import { Register } from "../types/users"
import { requiredPwd, requiredEmail } from "../utils/auth"

const email = ref("")
const password = ref("")
const confirm_pwd = ref("")
const first_name = ref("")
const last_name = ref("")
const username = ref("")

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

const checkInfo = () => {
    if (password.value === confirm_pwd.value && checkPwd() && checkEmail()) {
        if (first_name.value != "" && last_name.value != "") return true
    }

    return false
}

const handleRegister = () => {
    if (checkInfo()) {
        const user: Register = {
            user: {
                username: username.value,
                first_name: first_name.value,
                last_name: last_name.value,
                password: password.value,
                email: email.value,
                role: "user",
            },
        }
        const res = create_user(user)
        console.log(res)
        router.push("/user")
    }
}
const handleLogin = () => {
    router.push("/")
}
</script>

<template>
    <div class="container-register">
        <h1>Register</h1>
        <q-input class="input-text-register" color="secondary" outlined type="text" label="Username" v-model="username"> </q-input>

        <q-input class="input-text-register" color="secondary" outlined type="text" label="First Name" v-model="first_name"> </q-input>

        <q-input class="input-text-register" color="secondary" outlined type="text" label="Last Name" v-model="last_name"> </q-input>
        <q-input class="input-text-register" color="secondary" outlined type="text" label="Email" v-model="email" :rules="[checkEmail]"> </q-input>
        <q-input class="input-text-register" color="secondary" outlined type="password" v-model="password" label="Password" :rules="[checkPwd]"> </q-input>
        <q-input class="input-text-register" color="secondary" outlined type="password" v-model="confirm_pwd" label="Confirm your password" :rules="[checkPwd]"> </q-input>
        <div class="wrapper-btn">
            <q-btn class="register-btn" label="Register" type="submit" color="secondary" push hover="positive" @click="handleRegister"> </q-btn>
            <q-btn class="login-btn" label="Login" type="submit" color="secondary" push hover="positive" @click="handleLogin"> </q-btn>
        </div>
    </div>
</template>

<style lang="scss">
.container-register {
    width: 100%;

    .input-text-register {
        margin: 20px;
    }
    .wrapper-btn {
        display: flex;
        align-items: center;
        justify-content: center;
        flex-direction: column;
        .register-btn {
            padding: 1vh 2vh;
            margin: 2vh 4vh;
        }
    }
}
</style>
