<script setup lang="ts">
import Login from "../components/Login.vue"
import router from "../router"

const handleClick = () => {
    router.push("/register")
}
</script>

<template>
    <header></header>
    <main class="container">
        <Login />

        <div>
            <q-btn class="register" label="Register" type="submit" color="secondary" push hover="positive" @click="handleClick"> </q-btn>
        </div>
    </main>
</template>

<style scoped>
.container {
    /* color: var(--color-text); */
    display: flex;
    flex-direction: column;
}
.register {
    padding: 1vh 2vh;
    margin: 2vh 0vh;
}
</style>
