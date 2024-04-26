<script setup lang="ts">
import { Ref, inject, computed, ref } from "vue"
import InputProfile from "./user_profile/InputProfile.vue"
import { reset_password } from "../api/user"
import { User } from "../types/users"
import router from "../router";
const default_user = ref<User>({
    id: "0",
    username: "name",
    email: "mail",
    first_name: "first name",
    last_name: "last name",
    password: ""
})

const connected_user = inject<Ref<User>>("connected_user")

const user = computed(() => {
    if (connected_user?.value == null) {
        return default_user.value
    }
    return connected_user.value
})

const handleCancel = () => {
    console.log("Cancel change ")
    router.push("/user")
}
const handleChange = () => {
    if (connected_user?.value) {
        try {
            const res = reset_password(connected_user?.value.password.toString())
            alert("Password change with success :  " + res)
        } catch {
            alert("Failed to reset password")
        }
    }
}
</script>

<template>
    <q-avatar size="20vh">
        <img src="../assets/user_image.png" alt=""/>
    </q-avatar>
    <div class="container-profile">
        <InputProfile title="First name" :value="user.first_name" bg="#C0D3F5"></InputProfile>
        <InputProfile title="Last name" :value="user.last_name" bg="#FFC5C4"></InputProfile>
        <InputProfile title="Username" :value="user.username" bg="#FDEEBD"></InputProfile>
        <InputProfile title="email" :value="user.email" bg="#F0E3F7"></InputProfile>
        <InputProfile title="Password" type="password" :value="user.password" bg="#CEE0D5"></InputProfile>
        <div class="profil_button">
            <q-btn color="red" label="Cancel" @click="handleCancel" />
            <q-btn color="green" label="Update changes" @click="handleChange" />
        </div>
    </div>
</template>

<style>
.q-avatar {
    margin-top: 20px;
}
.container-profile-user {
    /* color: var(--color-text); */
    display: flex;
    flex-direction: column;
    width: 363px;
    height: 560px;
    flex-shrink: 0;
    border-radius: 14px;
    background: #f8f8f8;
}

.firt_name {
    width: 316;
    height: 52 ;

    /* shape: RoundedCornerShape(size = 10.dp) */
}

.profil_button {
  display: flex;
  flex-direction: row;
  justify-content: space-around;
  padding-bottom: 3vh;
}
</style>
